variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location of the resources"
  type        = string
}

variable "sa_name" {
  description = "Name of the Storage Account"
  type        = string
}

variable "sa_replication_type" {
  description = "Storage account replication type"
  type        = string
  default     = "LRS"
}

variable "sa_container_name" {
  description = "Name of the blob container"
  type        = string
  default     = "app-content"
}

variable "application_source_dir" {
  description = "Path to the application source directory to archive"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}