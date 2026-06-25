import {
  id = "/subscriptions/821f0b19-ec7a-4bb5-8eb0-7ee84fe42c3b/resourceGroups/cmtr-7c5kvppd-mod7-rg"
  to = azurerm_resource_group.rg
}

import {
  id = "/subscriptions/821f0b19-ec7a-4bb5-8eb0-7ee84fe42c3b/resourceGroups/cmtr-7c5kvppd-mod7-rg/providers/Microsoft.Storage/storageAccounts/cmtr7c5kvppdmod7sa"
  to = azurerm_storage_account.sa
}

import {
  id = "/subscriptions/821f0b19-ec7a-4bb5-8eb0-7ee84fe42c3b/resourceGroups/cmtr-7c5kvppd-mod7-rg/providers/Microsoft.Cdn/profiles/cmtr-7c5kvppd-mod7-fd-profile"
  to = module.cdn.azurerm_cdn_frontdoor_profile.profile
}

import {
  id = "/subscriptions/821f0b19-ec7a-4bb5-8eb0-7ee84fe42c3b/resourceGroups/cmtr-7c5kvppd-mod7-rg/providers/Microsoft.Cdn/profiles/cmtr-7c5kvppd-mod7-fd-profile/afdEndpoints/cmtr-7c5kvppd-mod7-fd-endpoint"
  to = module.cdn.azurerm_cdn_frontdoor_endpoint.endpoint
}

import {
  id = "/subscriptions/821f0b19-ec7a-4bb5-8eb0-7ee84fe42c3b/resourceGroups/cmtr-7c5kvppd-mod7-rg/providers/Microsoft.Cdn/profiles/cmtr-7c5kvppd-mod7-fd-profile/originGroups/cmtr-7c5kvppd-mod7-fd-origin-group"
  to = module.cdn.azurerm_cdn_frontdoor_origin_group.origin_group
}

import {
  id = "/subscriptions/821f0b19-ec7a-4bb5-8eb0-7ee84fe42c3b/resourceGroups/cmtr-7c5kvppd-mod7-rg/providers/Microsoft.Cdn/profiles/cmtr-7c5kvppd-mod7-fd-profile/originGroups/cmtr-7c5kvppd-mod7-fd-origin-group/origins/cmtr-7c5kvppd-mod7-fd-origin"
  to = module.cdn.azurerm_cdn_frontdoor_origin.origin
}

import {
  id = "/subscriptions/821f0b19-ec7a-4bb5-8eb0-7ee84fe42c3b/resourceGroups/cmtr-7c5kvppd-mod7-rg/providers/Microsoft.Cdn/profiles/cmtr-7c5kvppd-mod7-fd-profile/afdEndpoints/cmtr-7c5kvppd-mod7-fd-endpoint/routes/default"
  to = module.cdn.azurerm_cdn_frontdoor_route.route
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_storage_account" "sa" {
  name                     = var.storage_account_name
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  lifecycle {
    ignore_changes = [
      account_kind,
      access_tier,
      min_tls_version,
      allow_nested_items_to_be_public,
      shared_access_key_enabled,
      public_network_access_enabled,
      blob_properties,
      network_rules,
      tags,
    ]
  }
}

module "cdn" {
  source               = "./modules/cdn"
  fd_profile_name      = var.fd_profile_name
  fd_profile_sku       = var.fd_profile_sku
  fd_endpoint_name     = var.fd_endpoint_name
  fd_origin_group_name = var.fd_origin_group_name
  fd_origin_name       = var.fd_origin_name
  fd_route_name        = var.fd_route_name
  resource_group_name  = azurerm_resource_group.rg.name
  blob_host            = local.storage_account_primary_blob_host
  tags                 = var.tags
}