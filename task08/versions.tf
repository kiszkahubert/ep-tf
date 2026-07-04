terraform {
  required_version = ">= 1.5.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.110.0, < 4.0.0"
    }
    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = "3.2.0"
    }
    kubectl = {
      source  = "alekc/kubectl"
      version = ">= 2.0.0"
    }
  }
}

provider "azurerm" {
  features {}
  subscription_id = "821f0b19-ec7a-4bb5-8eb0-7ee84fe42c3b"
}

provider "kubernetes" {
  host                   = module.aks.kube_config_host
  client_certificate     = module.aks.kube_config_client_certificate
  client_key             = module.aks.kube_config_client_key
  cluster_ca_certificate = module.aks.kube_config_cluster_ca_certificate
}

provider "kubectl" {
  host                   = module.aks.kube_config_host
  client_certificate     = module.aks.kube_config_client_certificate
  client_key             = module.aks.kube_config_client_key
  cluster_ca_certificate = module.aks.kube_config_cluster_ca_certificate
  load_config_file       = false
}