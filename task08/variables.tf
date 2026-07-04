variable "name_prefix" {
  description = "Prefix used to name all resources"
  type        = string
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
}

variable "git_pat" {
  description = "Personal Access Token for the git repository containing the application source"
  type        = string
  sensitive   = true
}

variable "git_repo_url" {
  description = "URL of the git repository containing the application Dockerfile"
  type        = string
}

variable "tags" {
  description = "Common tags to apply to all resources"
  type        = map(string)
}