variable "name" {
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

variable "worker_count" {
  description = "Number of workers for the app service plan"
  type        = number
}

variable "tags" {
  description = "Tags to apply to the app service plan"
  type        = map(string)
}