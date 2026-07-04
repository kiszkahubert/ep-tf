output "aks_id" {
  description = "ID of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.id
}

output "aks_name" {
  description = "Name of the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.name
}

output "kube_config" {
  description = "Kubeconfig for the AKS cluster"
  value       = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive   = true
}

output "kube_config_host" {
  description = "Host from kubeconfig"
  value       = azurerm_kubernetes_cluster.aks.kube_config[0].host
  sensitive   = true
}

output "kube_config_client_certificate" {
  description = "Client certificate from kubeconfig"
  value       = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_certificate)
  sensitive   = true
}

output "kube_config_client_key" {
  description = "Client key from kubeconfig"
  value       = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].client_key)
  sensitive   = true
}

output "kube_config_cluster_ca_certificate" {
  description = "Cluster CA certificate from kubeconfig"
  value       = base64decode(azurerm_kubernetes_cluster.aks.kube_config[0].cluster_ca_certificate)
  sensitive   = true
}

output "kubelet_identity_object_id" {
  description = "Object ID of the AKS kubelet identity"
  value       = azurerm_kubernetes_cluster.aks.kubelet_identity[0].object_id
}

output "aks_kv_access_identity_id" {
  description = "Client ID of the Key Vault secrets provider identity"
  value       = azurerm_kubernetes_cluster.aks.key_vault_secrets_provider[0].secret_identity[0].client_id
}