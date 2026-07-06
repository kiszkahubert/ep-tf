variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location of the resources"
  type        = string
}

variable "acr_name" {
  description = "Name of the ACR"
  type        = string
}

variable "image_name" {
  description = "Name of the Docker image to build"
  type        = string
}

variable "context_path" {
  description = "Blob URL of the application source .tar.gz"
  type        = string
}

variable "context_access_token" {
  description = "SAS token for the Storage Account blob container"
  type        = string
  sensitive   = true
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "build_task_name" {
  description = "Build Task name"
  type        = string
  default     = "build-task"
}