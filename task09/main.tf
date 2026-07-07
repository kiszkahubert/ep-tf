data "azurerm_resource_group" "this" {
  name = local.rg_name
}

data "azurerm_virtual_network" "this" {
  name                = local.vnet_name
  resource_group_name = data.azurerm_resource_group.this.name
}

data "azurerm_subnet" "aks" {
  name                 = var.aks_subnet_name
  virtual_network_name = data.azurerm_virtual_network.this.name
  resource_group_name  = data.azurerm_resource_group.this.name
}

module "afw" {
  source                         = "./modules/afw"
  afs_subnet_name                = var.afs_subnet_name
  resource_group_name            = data.azurerm_resource_group.this.name
  location                       = var.location
  vnet_name                      = data.azurerm_virtual_network.this.name
  firewall_subnet_address_prefix = var.firewall_subnet_address_prefix
  firewall_name                  = local.firewall_name
  public_ip_name                 = local.public_ip_name
  route_table_name               = local.route_table_name
  aks_subnet_id                  = data.azurerm_subnet.aks.id
  aks_subnet_address_prefix      = data.azurerm_subnet.aks.address_prefixes[0]
  aks_loadbalancer_ip            = var.aks_loadbalancer_ip
}