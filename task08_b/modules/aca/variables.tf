variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location of the resources"
  type        = string
}

variable "aca_name" {
  description = "Name of the Azure Container App"
  type        = string
}

variable "aca_env_name" {
  description = "Name of the Azure Container App Environment"
  type        = string
}

variable "acr_login_server" {
  description = "Login server of the ACR"
  type        = string
}

variable "acr_id" {
  description = "ID of the ACR"
  type        = string
}

variable "key_vault_id" {
  description = "ID of the Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "redis_hostname_secret_id" {
  description = "Key Vault secret ID for the Redis hostname"
  type        = string
}

variable "redis_password_secret_id" {
  description = "Key Vault secret ID for the Redis password"
  type        = string
}

variable "image_name" {
  description = "Name of the Docker image to deploy"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}