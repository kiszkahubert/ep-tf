data "archive_file" "app_source" {
  type        = "tar.gz"
  source_dir  = var.application_source_dir
  output_path = "${path.module}/build/app_source.tar.gz"
}

resource "time_static" "sas_start" {}

resource "time_offset" "sas_expiry" {
  base_rfc3339 = time_static.sas_start.rfc3339
  offset_hours = 24
}

resource "azurerm_storage_account" "sa" {
  name                     = var.sa_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = "Standard"
  account_replication_type = var.sa_replication_type
  tags                     = var.tags
}

resource "azurerm_storage_container" "container" {
  name                  = var.sa_container_name
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "private"
}

resource "azurerm_storage_blob" "app_archive" {
  name                   = "app_source.tar.gz"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block"
  source                 = data.archive_file.app_source.output_path
}
data "azurerm_storage_account_blob_container_sas" "sas" {
  connection_string = azurerm_storage_account.sa.primary_connection_string
  container_name    = azurerm_storage_container.container.name
  https_only        = true
  start             = time_static.sas_start.rfc3339
  expiry            = time_offset.sas_expiry.rfc3339
  permissions {
    read   = true
    add    = false
    create = false
    write  = false
    delete = false
    list   = false
  }
}