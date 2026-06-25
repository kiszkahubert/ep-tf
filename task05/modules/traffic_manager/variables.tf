variable "name" {
  description = "Name of the Traffic Manager Profile"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "routing_method" {
  description = "Routing method for the Traffic Manager Profile"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Traffic Manager Profile"
  type        = map(string)
}

variable "endpoints" {
  description = "Map of Azure endpoints to add to the Traffic Manager Profile"
  type = map(object({
    name               = string
    target_resource_id = string
    weight             = optional(number, 1)
  }))
}