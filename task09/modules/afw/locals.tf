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
}