output "vm_public_ip" {
  description = "Public IP address of the Virtual Machine"
  value       = azurerm_linux_virtual_machine.vm.public_ip_address
}

output "vm_fqdn" {
  description = "FQDN of the Virtual Machine"
  value       = azurerm_public_ip.pip.fqdn
}