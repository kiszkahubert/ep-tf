import {
  id = "/subscriptions/821f0b19-ec7a-4bb5-8eb0-7ee84fe42c3b/resourceGroups/cmtr-7c5kvppd-mod7-rg/providers/Microsoft.Cdn/profiles/cmtr-7c5kvppd-mod7-fd-profile"
  to = azurerm_cdn_frontdoor_profile.profile
}

import {
  id = "/subscriptions/821f0b19-ec7a-4bb5-8eb0-7ee84fe42c3b/resourceGroups/cmtr-7c5kvppd-mod7-rg/providers/Microsoft.Cdn/profiles/cmtr-7c5kvppd-mod7-fd-profile/afdEndpoints/cmtr-7c5kvppd-mod7-fd-endpoint"
  to = azurerm_cdn_frontdoor_endpoint.endpoint
}

import {
  id = "/subscriptions/821f0b19-ec7a-4bb5-8eb0-7ee84fe42c3b/resourceGroups/cmtr-7c5kvppd-mod7-rg/providers/Microsoft.Cdn/profiles/cmtr-7c5kvppd-mod7-fd-profile/originGroups/cmtr-7c5kvppd-mod7-fd-origin-group"
  to = azurerm_cdn_frontdoor_origin_group.origin_group
}

import {
  id = "/subscriptions/821f0b19-ec7a-4bb5-8eb0-7ee84fe42c3b/resourceGroups/cmtr-7c5kvppd-mod7-rg/providers/Microsoft.Cdn/profiles/cmtr-7c5kvppd-mod7-fd-profile/originGroups/cmtr-7c5kvppd-mod7-fd-origin-group/origins/cmtr-7c5kvppd-mod7-fd-origin"
  to = azurerm_cdn_frontdoor_origin.origin
}

import {
  id = "/subscriptions/821f0b19-ec7a-4bb5-8eb0-7ee84fe42c3b/resourceGroups/cmtr-7c5kvppd-mod7-rg/providers/Microsoft.Cdn/profiles/cmtr-7c5kvppd-mod7-fd-profile/afdEndpoints/cmtr-7c5kvppd-mod7-fd-endpoint/routes/default"
  to = azurerm_cdn_frontdoor_route.route
}

resource "azurerm_cdn_frontdoor_profile" "profile" {
  name                = var.fd_profile_name
  resource_group_name = var.resource_group_name
  sku_name            = var.fd_profile_sku
  tags                = var.tags
}

resource "azurerm_cdn_frontdoor_endpoint" "endpoint" {
  name                     = var.fd_endpoint_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.profile.id
  tags                     = var.tags
}

resource "azurerm_cdn_frontdoor_origin_group" "origin_group" {
  name                     = var.fd_origin_group_name
  cdn_frontdoor_profile_id = azurerm_cdn_frontdoor_profile.profile.id
  load_balancing {
    sample_size                 = 4
    successful_samples_required = 3
  }
  health_probe {
    path                = "/"
    request_type        = "HEAD"
    protocol            = "Https"
    interval_in_seconds = 100
  }
}

resource "azurerm_cdn_frontdoor_origin" "origin" {
  name                           = var.fd_origin_name
  cdn_frontdoor_origin_group_id  = azurerm_cdn_frontdoor_origin_group.origin_group.id
  host_name                      = var.blob_host
  origin_host_header             = var.blob_host
  http_port                      = 80
  https_port                     = 443
  priority                       = 1
  weight                         = 1000
  certificate_name_check_enabled = true
}

resource "azurerm_cdn_frontdoor_route" "route" {
  name                          = var.fd_route_name
  cdn_frontdoor_endpoint_id     = azurerm_cdn_frontdoor_endpoint.endpoint.id
  cdn_frontdoor_origin_group_id = azurerm_cdn_frontdoor_origin_group.origin_group.id
  cdn_frontdoor_origin_ids      = [azurerm_cdn_frontdoor_origin.origin.id]
  forwarding_protocol           = "HttpsOnly"
  https_redirect_enabled        = true
  patterns_to_match             = ["/*"]
  supported_protocols           = ["Http", "Https"]
  depends_on = [
    azurerm_cdn_frontdoor_origin.origin,
    azurerm_cdn_frontdoor_origin_group.origin_group
  ]
}