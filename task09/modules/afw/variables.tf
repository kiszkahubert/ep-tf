variable "afs_subnet_name" {
  description = "AFS subnet name"
  type        = string
}

variable "resource_group_name" {
  description = "RG name"
  type        = string
}

variable "location" {
  description = "Location for resources"
  type        = string
}

variable "vnet_name" {
  description = "Existing VNET name to attach the firewall subnet to"
  type        = string
}

variable "firewall_subnet_address_prefix" {
  type        = string
  description = "Address prefix for the AzureFirewallSubnet"
}

variable "firewall_name" {
  type        = string
  description = "Name of the Azure Firewall"
}

variable "public_ip_name" {
  type        = string
  description = "Public IP name"
}

variable "route_table_name" {
  type        = string
  description = "Route table name"
}

variable "aks_subnet_id" {
  type        = string
  description = "ID of AKS cluster subnet"
}

variable "aks_subnet_address_prefix" {
  type        = string
  description = "Address prefix of AKS cluster subnet"
}

variable "aks_loadbalancer_ip" {
  type        = string
  description = "Public IP address of the AKS load balancer"
}