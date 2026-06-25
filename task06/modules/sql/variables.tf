variable "mssql_server_name" {
  description = "mssql Server name"
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name"
  type        = string
}

variable "location" {
  description = "Resource location"
  type        = string
}

variable "mssql_firewall_rule_name" {
  description = "Name of mssql Server Firewall rule"
  type        = string
}

variable "allowed_ip_address" {
  description = "Host IP address"
  type        = string
}

variable "mssql_database_name" {
  description = "mssql database name"
  type        = string
}

variable "mssql_database_sku_name" {
  description = "SKU name of mssql database"
  type        = string
}

variable "administrator_login" {
  description = "Administrator login"
  type        = string
}

variable "azure_services_firewall_rule_name" {
  description = "Name of Azure mssql firewal rule which allows all Azure services"
  type        = string
  default     = "allow-azure-services"
}

variable "kv_secret_admin_name" {
  description = "Key Value secret name for SQL admin username"
  type        = string
}

variable "kv_secret_admin_password" {
  description = "Key Value secret name for SQL admin password"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
}

variable "key_vault_id" {
  description = "ID of the Key Vault to store secrets"
  type        = string
}