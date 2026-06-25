variable "name" {
  description = "Name of the Windows Web App"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region for the Windows Web App"
  type        = string
}

variable "service_plan_id" {
  description = "ID of the App Service Plan"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Windows Web App"
  type        = map(string)
}

variable "ip_restrictions" {
  description = "List of IP restriction rules for the Web App"
  type = list(object({
    name        = string
    action      = string
    priority    = number
    ip_address  = optional(string)
    service_tag = optional(string)
  }))
}