variable "name_prefix" {
  description = "Prefix used to generate all resource names"
  type        = string
}

variable "location" {
  description = "Azure region for all resources"
  type        = string
}

variable "key_vault_name" {
  description = "Name of the existing Key Vault"
  type        = string
}

variable "key_vault_resource_group_name" {
  description = "Resource group name of the existing Key Vault"
  type        = string
}

variable "kv_secret_admin_name" {
  description = "Key Vault secret name for SQL admin username"
  type        = string
}

variable "kv_secret_admin_password" {
  description = "Key Vault secret name for SQL admin password"
  type        = string
}

variable "sql_firewall_rule_name" {
  description = "Name of the SQL firewall rule for verification IP"
  type        = string
}

variable "allowed_ip_address" {
  description = "IP address allowed to connect to SQL Server"
  type        = string
}

variable "sql_database_sku" {
  description = "SKU for the SQL Database"
  type        = string
}

variable "asp_sku" {
  description = "SKU for the App Service Plan"
  type        = string
}

variable "dotnet_version" {
  description = "Dotnet version for the Linux Web App"
  type        = string
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
}

variable "connection_string_name" {
  description = "Connection string name"
  type        = string
}
