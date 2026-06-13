variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Location for all resources"
  type        = string
}

variable "vnet_address_space" {
  description = "VNet address space"
  type        = string
}

variable "vnet_name" {
  description = "VNet name"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
}

variable "subnet_name" {
  description = "Subnet name"
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Subnet address prefixes"
  type        = list(string)
}

variable "public_ip_name" {
  description = "Public IP name"
  type        = string
}

variable "nsg_name" {
  description = "NSG name"
  type        = string
}

variable "nsg_rule1_name" {
  description = "NSG rule name"
  type        = string
}

variable "nsg_rule2_name" {
  description = "NSG rule name"
  type        = string
}

variable "nic_name" {
  description = "Network interface name"
  type        = string
}

variable "vm_name" {
  description = "Virtual Machine name"
  type        = string
}

variable "vm_admin_username" {
  description = "Virtual Machine username"
  type        = string
}

variable "vm_password" {
  description = "Virtual Machine password"
  type        = string
  sensitive   = true
}

variable "dns_name_label" {
  description = "DNS Name label"
  type        = string
}

variable "ip_cfg_name" {
  description = "IP config name"
  type = string
}