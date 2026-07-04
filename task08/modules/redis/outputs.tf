output "redis_id" {
  description = "ID of the Redis Cache instance"
  value       = azurerm_redis_cache.redis.id
}

output "redis_hostname" {
  description = "Hostname of the Redis Cache instance"
  value       = azurerm_redis_cache.redis.hostname
}

output "redis_primary_access_key" {
  description = "Primary access key of the Redis Cache instance"
  value       = azurerm_redis_cache.redis.primary_access_key
  sensitive   = true
}

output "redis_ssl_port" {
  description = "SSL port of the Redis Cache instance"
  value       = azurerm_redis_cache.redis.ssl_port
}