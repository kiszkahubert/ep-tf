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

variable "git_repo_url" {
  description = "URL of the git repository containing the Dockerfile"
  type        = string
}

variable "git_pat" {
  description = "Personal Access Token for the git repository"
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