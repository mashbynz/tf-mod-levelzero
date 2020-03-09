## Hub VNet/Firewall
# Firewall Resource Group
resource "azurerm_resource_group" "firewall" {
  count    = var.fw_rg_enabled == true ? length(keys(var.fw_rg_config.location)) : 0
  name     = element(values(var.fw_rg_config.rg_name), count.index)
  location = element(values(var.fw_rg_config.location), count.index)
  tags     = element(values(var.fw_rg_config.tags), count.index)
}

# Firewall VNet
resource "azurerm_virtual_network" "firewall" {
  count               = var.fw_rg_enabled == true ? length(keys(var.fw_vnet_config.vnet_name)) : 0
  name                = element(values(var.fw_vnet_config.vnet_name), count.index)
  location            = azurerm_resource_group.firewall.*.location[count.index]
  resource_group_name = azurerm_resource_group.firewall.*.name[count.index]
  address_space       = element(values(var.fw_vnet_config.address_space), count.index)
  dns_servers         = element(values(var.fw_vnet_config.dns_servers), count.index)

# Subnets: https://www.hashicorp.com/blog/hashicorp-terraform-0-12-preview-for-and-for-each/
  dynamic "subnet" {
    for_each = [for s in var.fw_subnets : {
      name   = s.name
      prefix = cidrsubnet(element(values(var.fw_vnet_config.base_cidr_block), count.index), s.newbits, s.number)
    }]

    content {
      name           = subnet.value.name
      address_prefix = subnet.value.prefix
    }
  }

  tags = element(values(var.fw_vnet_config.tags), count.index)
}

# # Log Analytics resource group
# resource "azurerm_resource_group" "log_analytics" {
#   count    = var.la_rg_enabled == true ? length(keys(var.la_rg_config.location)) : 0
#   name     = element(values(var.la_rg_config.rg_name), count.index)
#   location = element(values(var.la_rg_config.location), count.index)
#   tags     = element(values(var.la_rg_config.tags), count.index)
# }
