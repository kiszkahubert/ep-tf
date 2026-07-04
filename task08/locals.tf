data "azurerm_client_config" "current" {}

locals {
  rg_name                       = "${var.name_prefix}-rg"
  aci_name                      = "${var.name_prefix}-ci"
  acr_name                      = "${replace(var.name_prefix, "-", "")}cr"
  aks_name                      = "${var.name_prefix}-aks"
  keyvault_name                 = "${var.name_prefix}-kv"
  redis_name                    = "${var.name_prefix}-redis"
  image_name                    = "${var.name_prefix}-app"
  build_task_name               = "${var.name_prefix}-build-task"
  redis_primary_key_secret_name = "redis-primary-key"
  redis_hostname_secret_name    = "redis-hostname"
}