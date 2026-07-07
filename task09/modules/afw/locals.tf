locals {
  ip_config_name               = "${var.firewall_name}-ipconfig"
  app_rule_collection_name     = "${var.firewall_name}-app-rc"
  network_rule_collection_name = "${var.firewall_name}-net-rc"
  nat_rule_collection_name     = "${var.firewall_name}-nat-rc"
  default_route_name           = "default-to-firewall"
  location_short               = replace(lower(var.location), " ", "")

  aks_required_fqdns = [
    "*.hcp.${local.location_short}.azmk8s.io",
    "*.tun.${local.location_short}.azmk8s.io",
    "mcr.microsoft.com",
    "*.data.mcr.microsoft.com",
    "management.azure.com",
    "login.microsoftonline.com",
    "*.microsoftonline.com",
    "packages.microsoft.com",
    "acs-mirror.azureedge.net",
    "*.opinsights.azure.com",
    "*.oms.opinsights.azure.com",
    "*.monitoring.azure.com"
  ]
  network_rules = [
    {
      name                  = "allow-dns"
      protocols             = ["UDP"]
      source_addresses      = [var.aks_subnet_address_prefix]
      destination_ports     = ["53"]
      destination_addresses = ["*"]
    },
    {
      name                  = "allow-ntp"
      protocols             = ["UDP"]
      source_addresses      = [var.aks_subnet_address_prefix]
      destination_ports     = ["123"]
      destination_addresses = ["*"]
    },
    {
      name                  = "allow-azure-cloud"
      protocols             = ["TCP"]
      source_addresses      = [var.aks_subnet_address_prefix]
      destination_ports     = ["443", "9000"]
      destination_addresses = ["AzureCloud"]
    },
    {
      name                  = "allow-azure-container-registry"
      protocols             = ["TCP"]
      source_addresses      = [var.aks_subnet_address_prefix]
      destination_ports     = ["443"]
      destination_addresses = ["AzureContainerRegistry"]
    },
    {
      name                  = "allow-inbound-to-lb"
      protocols             = ["TCP"]
      source_addresses      = ["*"]
      destination_ports     = ["80"]
      destination_addresses = [var.aks_loadbalancer_ip]
    }
  ]
  nat_rules = [
    {
      name               = "allow-nginx-inbound"
      source_addresses   = ["*"]
      destination_ports  = ["80"]
      protocols          = ["TCP"]
      translated_address = var.aks_loadbalancer_ip
      translated_port    = "80"
    }
  ]
}