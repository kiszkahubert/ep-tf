output "firewall_id" {
  description = "ID of the Azure Firewall"
  value       = azurerm_firewall.this.id
}

output "firewall_public_ip" {
  description = "Public IP address assigned to the Azure Firewall"
  value       = azurerm_public_ip.afw.ip_address
}

output "firewall_private_ip" {
  description = "Private IP address assigned to the Azure Firewall"
  value       = azurerm_firewall.this.ip_configuration[0].private_ip_address
}

output "route_table_id" {
  description = "Resource ID of the route table"
  value       = azurerm_route_table.this.id
}