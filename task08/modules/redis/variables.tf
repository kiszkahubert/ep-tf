variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location of the resources"
  type        = string
}

variable "redis_name" {
  description = "Name of the Redis Cache"
  type        = string
}

variable "key_vault_id" {
  description = "ID of the Key Vault to store Redis secrets"
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Key Vault secret name for Redis hostname"
  type        = string
}

variable "redis_primary_key_secret_name" {
  description = "Key Vault secret name for Redis primary access key"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}