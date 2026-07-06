resource "azurerm_resource_group" "rg" {
  name     = local.rg_name
  location = var.location
  tags     = var.tags
}

module "keyvault" {
  source                 = "./modules/keyvault"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  kv_name                = local.keyvault_name
  tenant_id              = data.azurerm_client_config.current.tenant_id
  current_user_object_id = data.azurerm_client_config.current.object_id
  tags                   = var.tags
}

module "aci_redis" {
  source                     = "./modules/aci_redis"
  resource_group_name        = azurerm_resource_group.rg.name
  location                   = azurerm_resource_group.rg.location
  redis_aci_name             = local.redis_aci_name
  key_vault_id               = module.keyvault.key_vault_id
  redis_hostname_secret_name = local.redis_hostname_secret_name
  redis_password_secret_name = local.redis_password_secret_name
  tags                       = var.tags
  depends_on                 = [module.keyvault]
}

module "storage" {
  source                 = "./modules/storage"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  sa_name                = local.sa_name
  application_source_dir = "${path.module}/application"
  tags                   = var.tags
}

module "acr" {
  source               = "./modules/acr"
  resource_group_name  = azurerm_resource_group.rg.name
  location             = azurerm_resource_group.rg.location
  acr_name             = local.acr_name
  image_name           = local.image_name
  build_task_name      = local.build_task_name
  context_path         = module.storage.blob_url
  context_access_token = module.storage.sas_token
  tags                 = var.tags
  depends_on           = [module.storage]
}

module "aks" {
  source                 = "./modules/aks"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  aks_name               = local.aks_name
  default_node_pool_name = "system"
  node_count             = 1
  vm_size                = "Standard_D2ads_v6"
  os_disk_type           = "Ephemeral"
  acr_id                 = module.acr.acr_id
  key_vault_id           = module.keyvault.key_vault_id
  tenant_id              = data.azurerm_client_config.current.tenant_id
  tags                   = var.tags
  depends_on             = [module.keyvault, module.acr]
}

data "azurerm_key_vault_secret" "redis_hostname" {
  name         = local.redis_hostname_secret_name
  key_vault_id = module.keyvault.key_vault_id
  depends_on   = [module.aci_redis]
}

data "azurerm_key_vault_secret" "redis_password" {
  name         = local.redis_password_secret_name
  key_vault_id = module.keyvault.key_vault_id
  depends_on   = [module.aci_redis]
}

module "aca" {
  source                   = "./modules/aca"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  aca_name                 = local.aca_name
  aca_env_name             = local.aca_env_name
  acr_login_server         = module.acr.acr_login_server
  acr_id                   = module.acr.acr_id
  key_vault_id             = module.keyvault.key_vault_id
  tenant_id                = data.azurerm_client_config.current.tenant_id
  redis_hostname_secret_id = data.azurerm_key_vault_secret.redis_hostname.id
  redis_password_secret_id = data.azurerm_key_vault_secret.redis_password.id
  image_name               = local.image_name
  tags                     = var.tags
  depends_on               = [module.acr, module.aci_redis, module.keyvault]
}

module "k8s" {
  source                     = "./modules/k8s"
  manifests_path             = "${path.module}/k8s-manifests"
  aks_kv_access_identity_id  = module.aks.aks_kv_access_identity_id
  kv_name                    = local.keyvault_name
  redis_hostname_secret_name = local.redis_hostname_secret_name
  redis_password_secret_name = local.redis_password_secret_name
  tenant_id                  = data.azurerm_client_config.current.tenant_id
  acr_login_server           = module.acr.acr_login_server
  image_name                 = local.image_name
  image_tag                  = "latest"
  depends_on                 = [module.aks, module.keyvault, module.acr, module.aci_redis]
}