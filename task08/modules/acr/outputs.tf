output "acr_id" {
  description = "ID of the Azure Container Registry"
  value       = azurerm_container_registry.acr.id
}

output "acr_name" {
  description = "Name of the Azure Container Registry"
  value       = azurerm_container_registry.acr.name
}

output "acr_login_server" {
  description = "Login server URL of the Azure Container Registry"
  value       = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  description = "Admin username of the Azure Container Registry"
  value       = azurerm_container_registry.acr.admin_username
}

output "acr_admin_password" {
  description = "Admin password of the Azure Container Registry"
  value       = azurerm_container_registry.acr.admin_password
  sensitive   = true
}

output "task_id" {
  description = "ID of the ACR build task"
  value       = azurerm_container_registry_task.build.id
}