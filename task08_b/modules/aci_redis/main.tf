resource "random_password" "redis_pwd" {
  length      = 24
  special     = false
  min_lower   = 1
  min_upper   = 1
  min_numeric = 1
}

resource "azurerm_container_group" "redis" {
  name                = var.redis_aci_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku                 = "Standard"
  ip_address_type     = "Public"
  dns_name_label      = var.redis_aci_name
  container {
    name   = "redis"
    image  = "mcr.microsoft.com/cbl-mariner/base/redis:6.2"
    cpu    = "0.5"
    memory = "1.5"
    ports {
      port     = 6379
      protocol = "TCP"
    }
    commands = [
      "redis-server",
      "--protected-mode", "no",
      "--requirepass", random_password.redis_pwd.result
    ]
  }
  tags = var.tags
}

resource "azurerm_key_vault_secret" "redis_hostname" {
  name         = var.redis_hostname_secret_name
  value        = azurerm_container_group.redis.fqdn
  key_vault_id = var.key_vault_id
}

resource "azurerm_key_vault_secret" "redis_password" {
  name         = var.redis_password_secret_name
  value        = random_password.redis_pwd.result
  key_vault_id = var.key_vault_id
}