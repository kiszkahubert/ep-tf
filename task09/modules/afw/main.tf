resource "azurerm_subnet" "afw" {
  name                 = var.afs_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.vnet_name
  address_prefixes     = [var.firewall_subnet_address_prefix]
}

resource "azurerm_public_ip" "afw" {
  name                = var.public_ip_name
  resource_group_name = var.resource_group_name
  location            = var.location
  allocation_method   = "Static"
  sku                 = "Standard"
  lifecycle {
    create_before_destroy = true
  }
}

resource "azurerm_firewall" "this" {
  name                = var.firewall_name
  resource_group_name = var.resource_group_name
  location            = var.location
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  ip_configuration {
    name                 = local.ip_config_name
    subnet_id            = azurerm_subnet.afw.id
    public_ip_address_id = azurerm_public_ip.afw.id
  }
}

resource "azurerm_route_table" "this" {
  name                = var.route_table_name
  resource_group_name = var.resource_group_name
  location            = var.location
  route {
    name                   = local.default_route_name
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.this.ip_configuration[0].private_ip_address
  }
}

resource "azurerm_subnet_route_table_association" "aks" {
  subnet_id      = var.aks_subnet_id
  route_table_id = azurerm_route_table.this.id
}

resource "azurerm_firewall_application_rule_collection" "this" {
  name                = local.app_rule_collection_name
  azure_firewall_name = azurerm_firewall.this.name
  resource_group_name = var.resource_group_name
  priority            = 100
  action              = "Allow"
  rule {
    name             = "allow-aks-fqdns"
    source_addresses = [var.aks_subnet_address_prefix]
    target_fqdns     = local.aks_required_fqdns
    protocol {
      port = 443
      type = "Https"
    }
    protocol {
      port = 80
      type = "Http"
    }
  }
}

resource "azurerm_firewall_network_rule_collection" "this" {
  name                = local.network_rule_collection_name
  azure_firewall_name = azurerm_firewall.this.name
  resource_group_name = var.resource_group_name
  priority            = 100
  action              = "Allow"
  rule {
    name                  = "allow-dns"
    protocols             = ["UDP"]
    source_addresses      = [var.aks_subnet_address_prefix]
    destination_addresses = ["*"]
    destination_ports     = ["53"]
  }
  rule {
    name                  = "allow-ntp"
    protocols             = ["UDP"]
    source_addresses      = [var.aks_subnet_address_prefix]
    destination_addresses = ["*"]
    destination_ports     = ["123"]
  }
  rule {
    name                  = "allow-azure-cloud"
    protocols             = ["TCP"]
    source_addresses      = [var.aks_subnet_address_prefix]
    destination_addresses = ["AzureCloud"]
    destination_ports     = ["443", "9000"]
  }
  rule {
    name                  = "allow-azure-container-registry"
    protocols             = ["TCP"]
    source_addresses      = [var.aks_subnet_address_prefix]
    destination_addresses = ["AzureContainerRegistry"]
    destination_ports     = ["443"]
  }
}

resource "azurerm_firewall_nat_rule_collection" "this" {
  name                = local.nat_rule_collection_name
  azure_firewall_name = azurerm_firewall.this.name
  resource_group_name = var.resource_group_name
  priority            = 100
  action              = "Dnat"
  rule {
    name                  = "allow-nginx-inbound"
    source_addresses      = ["*"]
    destination_addresses = [azurerm_public_ip.afw.ip_address]
    destination_ports     = ["80"]
    protocols             = ["TCP"]
    translated_address    = var.aks_loadbalancer_ip
    translated_port       = "80"
  }
}