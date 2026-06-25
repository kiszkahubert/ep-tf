data "azurerm_key_vault" "kv" {
  name                = var.key_vault_name
  resource_group_name = var.key_vault_resource_group_name
}

resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

module "sql" {
  source                   = "./modules/sql"
  mssql_server_name        = local.sql_server_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  administrator_login      = local.sql_admin_login
  mssql_firewall_rule_name = var.sql_firewall_rule_name
  allowed_ip_address       = var.allowed_ip_address
  mssql_database_name      = local.sql_db_name
  mssql_database_sku_name  = var.sql_database_sku
  key_vault_id             = data.azurerm_key_vault.kv.id
  kv_secret_admin_name     = var.kv_secret_admin_name
  kv_secret_admin_password = var.kv_secret_admin_password
  tags                     = var.tags
}

module "webapp" {
  source                 = "./modules/webapp"
  service_plan_name      = local.asp_name
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  sku                    = var.asp_sku
  linux_web_app_name     = local.app_name
  dotnet_version         = var.dotnet_version
  sql_connection_string  = module.sql.sql_connection_string
  connection_string_name = var.connection_string_name
  tags                   = var.tags
}