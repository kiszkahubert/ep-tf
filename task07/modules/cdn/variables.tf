variable "fd_profile_name" {
  description = "Name of the CDN Front Door Profile"
  type        = string
}

variable "fd_profile_sku" {
  description = "SKU of the CDN Front Door Profile"
  type        = string
}

variable "fd_endpoint_name" {
  description = "Name of the CDN Front Door Endpoint"
  type        = string
}

variable "fd_origin_group_name" {
  description = "Name of the CDN Front Door Origin Group"
  type        = string
}

variable "fd_origin_name" {
  description = "Name of the CDN Front Door Origin"
  type        = string
}

variable "fd_route_name" {
  description = "Name of the CDN Front Door Route"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "blob_host" {
  description = "Primary blob host of the Storage Account"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}