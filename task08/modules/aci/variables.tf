variable "aci_name" {
  description = "ACI Name"
  type = string
}

variable "location" {
  description = "Location of ACI"
  type = string
}

variable "resource_group_name" {
  description = "RG Name"
  type = string
}

variable "server_name" {
  description = "Image registry server name"
  type = string
}

variable "container_name" {
  description = "Name of the container"
  type = string
}

variable "image" {
  description = "Image for the container"
  type = string
}

variable "tags" {
  description = "Tags to apply to the resource"
  type = map(string)
}