variable "manifests_path" {
  description = "Path to the directory containing k8s manifests"
  type        = string
}

variable "aks_kv_access_identity_id" {
  description = "Client ID of the AKS Key Vault Secrets Provider identity"
  type        = string
}

variable "kv_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "redis_hostname_secret_name" {
  description = "Key Vault secret name for Redis hostname"
  type        = string
}

variable "redis_password_secret_name" {
  description = "Key Vault secret name for Redis password"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID"
  type        = string
}

variable "acr_login_server" {
  description = "Login server of the ACR"
  type        = string
}

variable "image_name" {
  description = "Name of the Docker image"
  type        = string
}

variable "image_tag" {
  description = "Tag"
  type        = string
  default     = "latest"
}