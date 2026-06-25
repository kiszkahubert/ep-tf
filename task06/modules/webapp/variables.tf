variable "service_plan_name" {
  description = "Name of the app service plan"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the RG"
  type        = string
}

variable "location" {
  description = "Region for the app service plan"
  type        = string
}

variable "sku" {
  description = "SKU for the app service plan"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the app service plan"
  type        = map(string)
}

variable "linux_web_app_name" {
  description = "Name of the Linux web app"
  type        = string
}

variable "dotnet_version" {
  description = "Dotnet version for the Linux Web App"
  type        = string
}

variable "sql_connection_string" {
  description = "SQL Database connection string"
  type        = string
  sensitive   = true
}

variable "connection_string_name" {
  description = "Connection string name"
  type        = string
}