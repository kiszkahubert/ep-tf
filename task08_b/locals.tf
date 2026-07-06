data "azurerm_client_config" "current" {}

locals {
  rg_name                    = "${var.name_prefix}-rg"
  acr_name                   = "${replace(var.name_prefix, "-", "")}cr"
  aks_name                   = "${var.name_prefix}-aks"
  keyvault_name              = "${var.name_prefix}-kv"
  redis_aci_name             = "${var.name_prefix}-redis-ci"
  sa_name                    = substr(replace("${var.name_prefix}sa", "-", ""), 0, 24)
  aca_env_name               = "${var.name_prefix}-cae"
  aca_name                   = "${var.name_prefix}-aca"
  image_name                 = "${var.name_prefix}-app"
  build_task_name            = "${var.name_prefix}-build-task"
  redis_hostname_secret_name = "redis-hostname"
  redis_password_secret_name = "redis-password"
}