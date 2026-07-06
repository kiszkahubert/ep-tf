output "aca_id" {
  description = "ID of the Azure Container App"
  value       = azurerm_container_app.app.id
}

output "aca_fqdn" {
  description = "FQDN of the Azure Container App"
  value       = azurerm_container_app.app.latest_revision_fqdn
}

output "aca_identity_principal_id" {
  description = "Principal ID of the ACA userassigned identity"
  value       = azurerm_user_assigned_identity.aca.principal_id
}