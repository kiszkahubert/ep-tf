resource_group_name     = "cmaz-7c5kvppd-mod4-rg"
location                = "West Europe"
vnet_name               = "cmaz-7c5kvppd-mod4-vnet"
vnet_address_space      = "10.0.0.0/16"
subnet_name             = "frontend"
subnet_address_prefixes = ["10.0.1.0/24"]
public_ip_name          = "cmaz-7c5kvppd-mod4-pip"
dns_name_label          = "cmaz-7c5kvppd-mod4-nginx"
nsg_name                = "cmaz-7c5kvppd-mod4-nsg"
nsg_rule1_name          = "AllowHTTP"
nsg_rule2_name          = "AllowSSH"
nic_name                = "cmaz-7c5kvppd-mod4-nic"
vm_name                 = "cmaz-7c5kvppd-mod4-vm"
vm_admin_username       = "adminuser"
tags = {
  Creator = "hubert_kiszka@epam.com"
}
ip_cfg_name = "internal"