variable "afs_subnet_name" {
  description = "Firewall Subnet name"
  type        = string
}

variable "name_prefix" {
  description = "Name prefix"
  type        = string
}

variable "location" {
  type        = string
  description = "Location of the resources"
}

variable "aks_subnet_name" {
  type        = string
  description = "Name of the existing AKS cluster subnet"
}

variable "firewall_subnet_address_prefix" {
  type        = string
  description = "Address prefix for AzureFirewallSubnet"
}

variable "aks_loadbalancer_ip" {
  type        = string
  description = "Public IP address of the AKS internal load balancer"
}