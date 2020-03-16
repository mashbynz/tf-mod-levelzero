## Resource Groups
resource "azurerm_resource_group" "rg" {
  for_each = var.resource_groups

  name     = "${each.value.name}${var.rg_suffix}"
  location = each.value.location
  tags     = lookup(each.value, "tags", null) == null ? local.tags : merge(local.tags, each.value.tags)
  # rg_tags??
}

## Networks
# VNet
resource "azurerm_virtual_network" "vnet" {
  for_each = var.networking_object.vnet

  name                = "${each.value.name}${var.vnet_suffix}"
  location            = each.value.location
  resource_group_name = each.value.virtual_network_rg
  address_space       = each.value.address_space

  # dns_servers = lookup(var.networking_object.vnet, "dns", null)
  dns_servers = each.value.dns

  dynamic "ddos_protection_plan" {
    for_each = each.value.enable_ddos_std == true ? [1] : []

    content {
      id     = each.value.ddos_id
      enable = each.value.enable_ddos_std
    }
  }
}

# Subnets
# resource "azurerm_subnet" "v_subnet" {
#   # lifecycle {
#   #       ignore_changes = [network_security_group_id]
#   #   }

#   for_each                = var.subnets

#   name                    = each.value.name
#   resource_group_name     = var.resource_group
#   virtual_network_name    = var.virtual_network_name
#   address_prefix          = each.value.cidr
#   service_endpoints       = lookup(each.value, "service_endpoints", [])
#   enforce_private_link_endpoint_network_policies = lookup(each.value, "enforce_private_link_endpoint_network_policies", null )
#   enforce_private_link_service_network_policies = lookup(each.value, "enforce_private_link_service_network_policies", null)

#   dynamic "delegation" {
#     for_each = lookup(each.value, "delegation", {}) != {} ? [1] : []

#     content {
#      name = lookup(each.value.delegation, "name", null)

#      service_delegation {
#        name = lookup(each.value.delegation.service_delegation, "name", null)
#        actions = lookup(each.value.delegation.service_delegation, "actions", null)
#      }
#     }
#   }

# }



# Traffic Analytics




# NSGs




# NSG Association





## Diagnostics




## Log Analytics






/*
## Hub VNet/Firewall
# Network Resource Group
resource "azurerm_resource_group" "firewall" {
  count    = var.fw_rg_enabled == true ? length(keys(var.fw_rg_config.location)) : 0
  name     = element(values(var.fw_rg_config.rg_name), count.index)
  location = element(values(var.fw_rg_config.location), count.index)
  tags     = element(values(var.fw_rg_config.tags), count.index)
}

# Hub VNet
resource "azurerm_virtual_network" "region1_firewall" {
  name                  = element(values(var.fw_vnet_config.vnet_name), 0)
  location              = var.location
  resource_group_name   = var.virtual_network_rg
  address_space         = var.networking_object.vnet.address_space
  tags                  = local.tags

  dns_servers           = lookup(var.networking_object.vnet, "dns", null)

   dynamic "ddos_protection_plan" {
    for_each = lookup(var.networking_object.vnet, "enable_ddos_std", false) == true ? [1] : []
    
    content {
      id     = var.networking_object.vnet.ddos_id
      enable = var.networking_object.vnet.enable_ddos_std
    }
  }
}


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

  # tags = element(values(var.fw_vnet_config.tags), count.index)
}

## Firewall



## VPN Gateway
resource "azurerm_public_ip" "gateway" {
  count               = var.fw_rg_enabled == true ? length(keys(var.vnetgw_config.public_ip_name)) : 0
  name                = element(values(var.vnetgw_config.public_ip_name), count.index)
  location            = azurerm_resource_group.firewall.*.location[count.index]
  resource_group_name = azurerm_resource_group.firewall.*.name[count.index]
  allocation_method   = element(values(var.vnetgw_config.public_ip_alocation_method), count.index)
}

resource "azurerm_subnet" "gateway" {
  count                = var.fw_rg_enabled == true ? length(keys(var.fw_vnet_config.vnet_name)) : 0
  name                 = element(values(var.vnetgw_config.gw_subnet_name), count.index)
  resource_group_name  = azurerm_resource_group.firewall.*.name[count.index]
  virtual_network_name = azurerm_virtual_network.firewall.*.name[count.index]
  address_prefix       = cidrsubnet(element(values(var.fw_vnet_config.base_cidr_block), count.index), element(values(var.vnetgw_config.gw_subnet_newbits), count.index), element(values(var.vnetgw_config.gw_subnet_number), count.index))
}

resource "azurerm_virtual_network_gateway" "gateway" {
  count               = var.fw_rg_enabled == true ? length(keys(var.vnetgw_config.public_ip_name)) : 0
  name                = element(values(var.vnetgw_config.gw_name), count.index)
  location            = azurerm_resource_group.firewall.*.location[count.index]
  resource_group_name = azurerm_resource_group.firewall.*.name[count.index]

  type     = element(values(var.vnetgw_config.gw_type), count.index)
  vpn_type = element(values(var.vnetgw_config.gw_vpn_type), count.index)

  active_active = element(values(var.vnetgw_config.gw_active_active), count.index)
  enable_bgp    = element(values(var.vnetgw_config.gw_enable_bgp), count.index)
  sku           = element(values(var.vnetgw_config.gw_sku), count.index)

  ip_configuration {
    name                          = element(values(var.vnetgw_config.gw_ip_configuration_name), count.index)
    public_ip_address_id          = azurerm_public_ip.gateway.*.id[count.index]
    private_ip_address_allocation = element(values(var.vnetgw_config.gw_ip_configuration_private_ip_allocation_method), count.index)
    subnet_id                     = azurerm_subnet.gateway.*.id[count.index]
  }
}

## Zscaler



## NSGs
resource "azurerm_network_security_group" "UntrustSubnet" {
  count               = var.fw_rg_enabled == true ? length(keys(var.fw_rg_config.location)) : 0
  name                = element(tolist(var.nsg_config.nsg_name), 0)
  location            = azurerm_resource_group.firewall.*.location[count.index]
  resource_group_name = azurerm_resource_group.firewall.*.name[count.index]

  dynamic "security_rule" {
    for_each = [for rule in var.UntrustSubnet_rules : {
      name                       = rule.name
      priority                   = rule.priority
      direction                  = rule.direction
      access                     = rule.access
      protocol                   = rule.protocol
      source_port_range          = rule.source_port_range
      destination_port_range     = rule.destination_port_range
      source_address_prefix      = rule.source_address_prefix
      destination_address_prefix = rule.destination_address_prefix
    }]

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix

    }
  }
}

resource "azurerm_network_security_group" "TrustedSubnet" {
  count               = var.fw_rg_enabled == true ? length(keys(var.fw_rg_config.location)) : 0
  name                = element(tolist(var.nsg_config.nsg_name), 1)
  location            = azurerm_resource_group.firewall.*.location[count.index]
  resource_group_name = azurerm_resource_group.firewall.*.name[count.index]

  dynamic "security_rule" {
    for_each = [for rule in var.TrustedSubnet_rules : {
      name                       = rule.name
      priority                   = rule.priority
      direction                  = rule.direction
      access                     = rule.access
      protocol                   = rule.protocol
      source_port_range          = rule.source_port_range
      destination_port_range     = rule.destination_port_range
      source_address_prefix      = rule.source_address_prefix
      destination_address_prefix = rule.destination_address_prefix
    }]

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix

    }
  }
}

resource "azurerm_network_security_group" "InternalSubnet" {
  count               = var.fw_rg_enabled == true ? length(keys(var.fw_rg_config.location)) : 0
  name                = element(tolist(var.nsg_config.nsg_name), 2)
  location            = azurerm_resource_group.firewall.*.location[count.index]
  resource_group_name = azurerm_resource_group.firewall.*.name[count.index]

  dynamic "security_rule" {
    for_each = [for rule in var.InternalSubnet_rules : {
      name                       = rule.name
      priority                   = rule.priority
      direction                  = rule.direction
      access                     = rule.access
      protocol                   = rule.protocol
      source_port_range          = rule.source_port_range
      destination_port_range     = rule.destination_port_range
      source_address_prefix      = rule.source_address_prefix
      destination_address_prefix = rule.destination_address_prefix
    }]

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix

    }
  }
}

resource "azurerm_network_security_group" "rvdb-sc-ul" {
  count               = var.fw_rg_enabled == true ? length(keys(var.fw_rg_config.location)) : 0
  name                = element(tolist(var.nsg_config.nsg_name), 3)
  location            = azurerm_resource_group.firewall.*.location[count.index]
  resource_group_name = azurerm_resource_group.firewall.*.name[count.index]

  dynamic "security_rule" {
    for_each = [for rule in var.rvdb-sc-ul_rules : {
      name                       = rule.name
      priority                   = rule.priority
      direction                  = rule.direction
      access                     = rule.access
      protocol                   = rule.protocol
      source_port_range          = rule.source_port_range
      destination_port_range     = rule.destination_port_range
      source_address_prefix      = rule.source_address_prefix
      destination_address_prefix = rule.destination_address_prefix
    }]

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix

    }
  }
}

resource "azurerm_network_security_group" "rvdb-sc-dl" {
  count               = var.fw_rg_enabled == true ? length(keys(var.fw_rg_config.location)) : 0
  name                = element(tolist(var.nsg_config.nsg_name), 4)
  location            = azurerm_resource_group.firewall.*.location[count.index]
  resource_group_name = azurerm_resource_group.firewall.*.name[count.index]

  dynamic "security_rule" {
    for_each = [for rule in var.rvdb-sc-dl_rules : {
      name                       = rule.name
      priority                   = rule.priority
      direction                  = rule.direction
      access                     = rule.access
      protocol                   = rule.protocol
      source_port_range          = rule.source_port_range
      destination_port_range     = rule.destination_port_range
      source_address_prefix      = rule.source_address_prefix
      destination_address_prefix = rule.destination_address_prefix
    }]

    content {
      name                       = security_rule.value.name
      priority                   = security_rule.value.priority
      direction                  = security_rule.value.direction
      access                     = security_rule.value.access
      protocol                   = security_rule.value.protocol
      source_port_range          = security_rule.value.source_port_range
      destination_port_range     = security_rule.value.destination_port_range
      source_address_prefix      = security_rule.value.source_address_prefix
      destination_address_prefix = security_rule.value.destination_address_prefix

    }
  }
}

# Associations


## Route Tables





# # Log Analytics resource group
# resource "azurerm_resource_group" "log_analytics" {
#   count    = var.la_rg_enabled == true ? length(keys(var.la_rg_config.location)) : 0
#   name     = element(values(var.la_rg_config.rg_name), count.index)
#   location = element(values(var.la_rg_config.location), count.index)
#   tags     = element(values(var.la_rg_config.tags), count.index)
# }
*/
