variable "name" {
  description = "Name of the Resource Group"
  type        = string
}

variable "location" {
  description = "Location of the resource group"
  type        = string
}

variable "tags" {
  description = "Tags to apply to the Resource group"
  type = map(string)
}