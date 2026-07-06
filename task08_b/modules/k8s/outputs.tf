output "lb_ip" {
  description = "Load Balancer IP address of the application service in AKS"
  value       = data.kubernetes_service_v1.app.status[0].load_balancer[0].ingress[0].ip
}