variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location of the resources"
  type        = string
}

variable "kv_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "current_user_object_id" {
  description = "Object ID of the current user/service principal"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}