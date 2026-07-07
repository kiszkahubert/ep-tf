locals {
  rg_name          = "${var.name_prefix}-rg"
  vnet_name        = "${var.name_prefix}-vnet"
  public_ip_name   = "${var.name_prefix}-pip"
  firewall_name    = "${var.name_prefix}-afw"
  route_table_name = "${var.name_prefix}-rt"
}