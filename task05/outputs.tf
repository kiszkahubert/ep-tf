output "traffic_manager_fqdn" {
  description = "FQDN of the Azure Traffic Manager Profile"
  value       = module.traffic_manager.fqdn
}