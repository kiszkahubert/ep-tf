resource_group_name    = "cmaz-7c5kvppd-mod3-rg"
location               = "West Europe"
storage_account_name   = "cmaz7c5kvppdsa"
vnet_name              = "cmaz-7c5kvppd-mod3-vnet"
vnet_address_space     = "10.0.0.0/16"
subnet_frontend_prefix = "10.0.1.0/24"
subnet_backend_prefix  = "10.0.2.0/24"
tags = {
  Creator = "hubert_kiszka@epam.com"
}
backend_subnet_name  = "backend"
frontend_subnet_name = "frontend"