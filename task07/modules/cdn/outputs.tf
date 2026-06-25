output "endpoint_hostname" {
  description = "Hostname of the CDN Front Door Endpoint"
  value       = azurerm_cdn_frontdoor_endpoint.endpoint.host_name
}