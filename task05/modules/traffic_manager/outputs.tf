output "id" {
  description = "ID of the Traffic Manager Profile"
  value       = azurerm_traffic_manager_profile.tm.id
}

output "fqdn" {
  description = "FQDN of the Traffic Manager Profile"
  value       = azurerm_traffic_manager_profile.tm.fqdn
}