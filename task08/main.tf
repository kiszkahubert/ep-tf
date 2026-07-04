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

module "redis" {
  source                        = "./modules/redis"
  resource_group_name           = azurerm_resource_group.rg.name
  location                      = azurerm_resource_group.rg.location
  redis_name                    = local.redis_name
  key_vault_id                  = module.keyvault.key_vault_id
  redis_hostname_secret_name    = local.redis_hostname_secret_name
  redis_primary_key_secret_name = local.redis_primary_key_secret_name
  tags                          = var.tags
  depends_on                    = [module.keyvault]
}

module "acr" {
  source              = "./modules/acr"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  acr_name            = local.acr_name
  image_name          = local.image_name
  git_repo_url        = var.git_repo_url
  git_pat             = var.git_pat
  build_task_name     = local.build_task_name
  tags                = var.tags
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
  depends_on   = [module.redis]
}

data "azurerm_key_vault_secret" "redis_primary_key" {
  name         = local.redis_primary_key_secret_name
  key_vault_id = module.keyvault.key_vault_id
  depends_on   = [module.redis]
}

module "aci" {
  source              = "./modules/aci"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  aci_name            = local.aci_name
  container_name      = local.aci_name
  acr_login_server    = module.acr.acr_login_server
  acr_admin_username  = module.acr.acr_admin_username
  acr_admin_password  = module.acr.acr_admin_password
  image_name          = local.image_name
  redis_url           = data.azurerm_key_vault_secret.redis_hostname.value
  redis_password      = data.azurerm_key_vault_secret.redis_primary_key.value
  tags                = var.tags
  depends_on          = [module.acr, module.redis]
}

resource "kubectl_manifest" "secret_provider" {
  yaml_body = templatefile("${path.module}/k8s-manifests/secret-provider.yaml.tftpl", {
    aks_kv_access_identity_id  = module.aks.aks_kv_access_identity_id
    kv_name                    = local.keyvault_name
    redis_url_secret_name      = local.redis_hostname_secret_name
    redis_password_secret_name = local.redis_primary_key_secret_name
    tenant_id                  = data.azurerm_client_config.current.tenant_id
  })
  depends_on = [module.aks, module.keyvault]
}

resource "kubectl_manifest" "deployment" {
  yaml_body = templatefile("${path.module}/k8s-manifests/deployment.yaml.tftpl", {
    acr_login_server = module.acr.acr_login_server
    app_image_name   = local.image_name
    image_tag        = "latest"
  })
  depends_on = [kubectl_manifest.secret_provider, module.acr, module.aks]
  wait_for {
    field {
      key        = "status.readyReplicas"
      value      = "1"
      value_type = "eq"
    }
  }
}

resource "kubectl_manifest" "service" {
  yaml_body  = file("${path.module}/k8s-manifests/service.yaml")
  depends_on = [kubectl_manifest.deployment]
}

data "kubernetes_service_v1" "app" {
  metadata {
    name = "redis-flask-app-service"
  }
  depends_on = [kubectl_manifest.service]
}