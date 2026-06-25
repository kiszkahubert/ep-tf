variable "resource_groups" {
  description = "Map of resource group objects"
  type = map(object({
    name     = string
    location = string
  }))
}

variable "app_service_plans" {
  description = "Map of App Service Plan objects"
  type = map(object({
    name         = string
    rg_key       = string
    sku          = string
    worker_count = number
  }))
}

variable "app_services" {
  description = "Map of Windows Web App objects"
  type = map(object({
    name    = string
    rg_key  = string
    asp_key = string
  }))
}

variable "traffic_manager_name" {
  description = "Name of the Traffic Manager Profile"
  type        = string
}

variable "traffic_manager_rg_key" {
  description = "Key of the resource group for Traffic Manager"
  type        = string
}

variable "traffic_manager_routing_method" {
  description = "Routing method for Traffic Manager"
  type        = string
}

variable "verification_agent_ip" {
  description = "IP address of the verification agent allowed through NSG"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all supported resources"
  type        = map(string)
}

variable "ip_restriction_allow_ip_name" {
  description = "Name of the IP restriction rule for verification agent IP"
  type        = string
}

variable "ip_restriction_allow_tm_name" {
  description = "Name of the IP restriction rule for Traffic Manager service tag"
  type        = string
}