variable "redis_aci_name" {
  description = "Redis ACI Name"
  type        = string
}

variable "location" {
  description = "Location of ACI"
  type        = string
}

variable "resource_group_name" {
  description = "RG Name"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the resource"
  type        = map(string)
}

variable "redis_hostname_secret_name" {
  description = "Redis hostname secret name"
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault ID"
  type        = string
}

variable "redis_password_secret_name" {
  description = "Redis password secret name"
  type        = string
}