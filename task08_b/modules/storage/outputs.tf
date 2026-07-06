output "sa_id" {
  description = "ID of the Storage Account"
  value       = azurerm_storage_account.sa.id
}

output "sa_name" {
  description = "Name of the Storage Account"
  value       = azurerm_storage_account.sa.name
}

output "container_name" {
  description = "Name of the Storage Container"
  value       = azurerm_storage_container.container.name
}

output "blob_url" {
  description = "URL of the uploaded application source archive blob"
  value       = azurerm_storage_blob.app_archive.url
}

output "sas_token" {
  description = "SAS token for the blob container"
  value       = data.azurerm_storage_account_blob_container_sas.sas.sas
  sensitive   = true
}