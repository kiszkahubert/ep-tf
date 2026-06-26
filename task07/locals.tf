locals {
  storage_account_primary_blob_host = azurerm_storage_account.sa.primary_blob_host
  fd_origin_path                    = "/${azurerm_storage_account.sa.name}/${var.blob_filename}"
}