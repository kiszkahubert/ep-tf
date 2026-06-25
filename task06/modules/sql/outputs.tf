output "sql_server_fqdn" {
  description = "FQDN of the SQL server"
  value       = azurerm_mssql_server.sql_server.fully_qualified_domain_name
}

output "sql_connection_string" {
  description = "Connection string for the SQL database"
  sensitive   = true
  value       = "Server=tcp:${azurerm_mssql_server.sql_server.fully_qualified_domain_name},1433;Initial Catalog=${azurerm_mssql_database.sql_database.name};Persist Security Info=False;User ID=${var.administrator_login};Password=${random_password.sql_password.result};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;"
}