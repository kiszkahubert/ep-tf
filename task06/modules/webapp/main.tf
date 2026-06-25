resource "azurerm_service_plan" "asp" {
  name                = var.service_plan_name
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = var.sku
  tags                = var.tags
}

resource "azurerm_linux_web_app" "linux_web_app" {
  name                = var.linux_web_app_name
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.asp.id
  site_config {
    application_stack {
      dotnet_version = var.dotnet_version
    }
  }
  connection_string {
    name  = var.connection_string_name
    type  = "SQLAzure"
    value = var.sql_connection_string
  }
  tags = var.tags
}