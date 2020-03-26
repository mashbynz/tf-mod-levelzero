output "resource_groups" {
  description = "Returns the full set of resource group objects created"
  depends_on  = [azurerm_resource_group.rg]

  value = azurerm_resource_group.rg
}

output "names" {
  description = "Returns a map of resource_group key -> resource_group name"
  depends_on  = [azurerm_resource_group.rg]

  value = {
    for group in keys(azurerm_resource_group.rg) :
    group => azurerm_resource_group.rg[group].name
  }
}

output "ids" {
  description = "Returns a map of resource_group key -> resource_group id"
  depends_on  = [azurerm_resource_group.rg]

  value = {
    for group in keys(azurerm_resource_group.rg) :
    group => azurerm_resource_group.rg[group].id
  }
}

output "virtual_networks" {
  description = "Returns the full set of virtual networks objects created"
  depends_on  = [azurerm_virtual_network.vnet]

  value = azurerm_virtual_network.vnet
}

output "subnets" {
  description = "Returns the full set of subnets created"
  depends_on  = [azurerm_subnet.v_subnet]

  value = azurerm_subnet.v_subnet
}

output "nsgs" {
  description = "Returns the full set of NSGs created"
  depends_on  = [azurerm_network_security_group.nsg_obj]

  value = azurerm_network_security_group.nsg_obj
}

output "route_table_obj" {
  description = "Returns the full set of Route Tables created"
  depends_on  = [azurerm_route_table.route_table]

  value = azurerm_route_table.route_table
}

output "ip_addresses" {
  description = "Returns the full set of IP Addresses created"
  depends_on  = [azurerm_public_ip.ip]

  value = azurerm_public_ip.ip
}
