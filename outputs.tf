output "level1_firewall_id" {
  value = azurerm_virtual_network.firewall.*.id
}
