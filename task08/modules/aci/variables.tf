variable "aci_name" {
  description = "ACI Name"
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

variable "acr_login_server" {
  description = "Image registry server name"
  type        = string
}

variable "container_name" {
  description = "Name of the container"
  type        = string
}

variable "image_name" {
  description = "Image for the container"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the resource"
  type        = map(string)
}

variable "acr_admin_username" {
  description = "ACR admin usernmae"
  type        = string
}

variable "acr_admin_password" {
  description = "ACR admin password"
  type        = string
  sensitive   = true
}

variable "redis_url" {
  description = "REDIS URL"
  type        = string
}

variable "redis_password" {
  description = "REDIS password"
  type        = string
  sensitive   = true
}