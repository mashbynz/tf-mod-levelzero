# output "level1_firewall_id" {
#   value = azurerm_virtual_network.firewall.*.id
# }

output "network_location" {
  value = azurerm_resource_group.firewall.*.location
}

output "network_resource_group_name" {
  value = azurerm_resource_group.firewall.*.name
}

# output "level0_la_rg_enabled" {
#   value = var.la_rg_config.rg_enabled
# }

# output "level0_fw_rg_enabled" {
#   value = var.fw_rg_config.rg_enabled
# }