output "redis_id" {
  description = "ID of the Redis Azure Container Instance"
  value       = azurerm_container_group.redis.id
}

output "redis_ip_address" {
  description = "Public IP address of the Redis Azure Container Instance"
  value       = azurerm_container_group.redis.ip_address
}

output "redis_fqdn" {
  description = "FQDN of the Redis Azure Container Instance"
  value       = azurerm_container_group.redis.fqdn
}

output "redis_password" {
  description = "Redis password"
  value       = random_password.redis_pwd.result
  sensitive   = true
}