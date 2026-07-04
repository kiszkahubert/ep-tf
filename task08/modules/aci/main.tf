resource "azurerm_container_group" "aci" {
  name                = var.aci_name
  location            = var.location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku                 = "Standard"
  ip_address_type     = "Public"
  dns_name_label      = var.aci_name

  image_registry_credential {
    server   = var.acr_login_server
    username = var.acr_admin_username
    password = var.acr_admin_password
  }
  
  container {
    name   = var.container_name
    image  = "${var.acr_login_server}/${var.image_name}:latest"
    cpu    = "0.5"
    memory = "1.5"
    ports {
      port     = 8080
      protocol = "TCP"
    }
    environment_variables = {
      CREATOR        = "ACI"
      REDIS_PORT     = "6380"
      REDIS_SSL_MODE = "True"
    }
    secure_environment_variables = {
      REDIS_URL = var.redis_url
      REDIS_PWD = var.redis_password
    }
  }
  tags = var.tags
}