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
  enabled                        = true
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
  cdn_frontdoor_origin_path     = var.fd_origin_path
  depends_on = [
    azurerm_cdn_frontdoor_endpoint.endpoint,
    azurerm_cdn_frontdoor_origin.origin,
    azurerm_cdn_frontdoor_origin_group.origin_group
  ]
}