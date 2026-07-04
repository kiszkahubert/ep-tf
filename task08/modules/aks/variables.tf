variable "resource_group_name" {
  description = "Name of the RG"
  type        = string
}

variable "location" {
  description = "Location of the resources"
  type        = string
}

variable "aks_name" {
  description = "AKS cluster name"
  type        = string
}

variable "default_node_pool_name" {
  description = "Default node pool name"
  type        = string
  default     = "system"
}

variable "node_count" {
  description = "Number of nodes in the default node pool"
  type        = number
  default     = 1
}

variable "acr_id" {
  description = "ACR ID"
  type        = string
}

variable "key_vault_id" {
  description = "Key Vault ID"
  type        = string
}

variable "tenant_id" {
  description = "Azure tenant ID"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "vm_size" {
  description = "VM Size"
  type        = string
  default     = "Standard_D2ads_v6"
}

variable "os_disk_type" {
  description = "OS disk type"
  type        = string
  default     = "Ephemeral"
}