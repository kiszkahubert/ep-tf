output "id" {
  description = "ID of the Windows Web App"
  value       = azurerm_windows_web_app.app.id
}

output "name" {
  description = "Name of the Windows Web App"
  value       = azurerm_windows_web_app.app.name
}

output "default_hostname" {
  description = "Default hostname of the Windows Web App"
  value       = azurerm_windows_web_app.app.default_hostname
}