module "resource_groups" {
  source   = "./modules/resource_group"
  for_each = var.resource_groups
  name     = each.value.name
  location = each.value.location
  tags     = var.tags
}

module "app_service_plans" {
  source   = "./modules/app_service_plan"
  for_each = var.app_service_plans
  name                = each.value.name
  resource_group_name = module.resource_groups[each.value.rg_key].name
  location            = module.resource_groups[each.value.rg_key].location
  sku                 = each.value.sku
  worker_count        = each.value.worker_count
  tags                = var.tags
  depends_on = [module.resource_groups]
}

module "app_services" {
  source   = "./modules/app_service"
  for_each = var.app_services
  name                = each.value.name
  resource_group_name = module.resource_groups[each.value.rg_key].name
  location            = module.resource_groups[each.value.rg_key].location
  service_plan_id     = module.app_service_plans[each.value.asp_key].id
  tags                = var.tags
  ip_restrictions = [
    {
      name       = "allow-ip"
      action     = "Allow"
      priority   = 100
      ip_address = "${var.verification_agent_ip}/32"
    },
    {
      name        = "allow-tm"
      action      = "Allow"
      priority    = 200
      service_tag = "AzureTrafficManager"
    }
  ]
  depends_on = [module.app_service_plans]
}

module "traffic_manager" {
  source = "./modules/traffic_manager"
  name                = var.traffic_manager_name
  resource_group_name = module.resource_groups[var.traffic_manager_rg_key].name
  routing_method      = var.traffic_manager_routing_method
  tags                = var.tags
  endpoints = {
    for key, app in module.app_services : key => {
      name               = app.name
      target_resource_id = app.id
    }
  }
  depends_on = [module.app_services]
}