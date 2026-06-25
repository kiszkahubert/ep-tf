resource_groups = {
  rg1 = {
    name     = "cmaz-7c5kvppd-mod5-rg-01"
    location = "West Europe"
  }
  rg2 = {
    name     = "cmaz-7c5kvppd-mod5-rg-02"
    location = "North Europe"
  }
  rg3 = {
    name     = "cmaz-7c5kvppd-mod5-rg-03"
    location = "East US"
  }
}
app_service_plans = {
  asp1 = {
    name         = "cmaz-7c5kvppd-mod5-asp-01"
    rg_key       = "rg1"
    sku          = "S1"
    worker_count = 2
  }
  asp2 = {
    name         = "cmaz-7c5kvppd-mod5-asp-02"
    rg_key       = "rg2"
    sku          = "S1"
    worker_count = 1
  }
}
app_services = {
  app1 = {
    name    = "cmaz-7c5kvppd-mod5-app-01"
    rg_key  = "rg1"
    asp_key = "asp1"
  }
  app2 = {
    name    = "cmaz-7c5kvppd-mod5-app-02"
    rg_key  = "rg2"
    asp_key = "asp2"
  }
}
traffic_manager_name           = "cmaz-7c5kvppd-mod5-traf"
traffic_manager_rg_key         = "rg3"
traffic_manager_routing_method = "Performance"
verification_agent_ip          = "18.153.146.156"
tags = {
  Creator = "hubert_kiszka@epam.com"
}