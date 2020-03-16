variable "resource_groups" {
  description = "(Required) Map of the resource groups to create"
}

# Example of resource_groups data structure:
# resource_groups = {
#   apim          = { 
#                   name     = "-apim-demo"
#                   location = "southeastasia" 
#                   },
#   networking    = {    
#                   name     = "-networking-demo"
#                   location = "southeastasia" 
#                   },
#   insights      = { 
#                   name     = "-insights-demo"
#                   location = "southeastasia" 
#                     tags = {
#                       project = "Pattaya"
#                       approver = "Gunter"
#                     }
#                   },
# }

variable "rg_suffix" {
  description = "(Optional) You can use a suffix to add to the list of resource groups you want to create"
}

variable "tags" {
  default     = ""
  description = "(Required) tags for the deployment"
}

# variable "virtual_network_rg" {
#   description = "(Required) Name of the resource group where to create the vnet"
#   type        = string
# }

# variable "location" {
#   description = "(Required) Define the region where the virtual networks will be created"
#   type        = string
# }

variable "vnet_suffix" {
  description = "(Optional) You can use a suffix to add to the list of virtual networks you want to create"
  type        = string
}

# variable "diagnostics_map" {
#   description = "(Required) contains the SA and EH details for operations diagnostics"
# }

# variable "log_analytics_workspace" {
#   description = "(Required) contains the log analytics workspace details for operations diagnostics"
# }

# variable "diagnostics_settings" {
#   description = "(Required) configuration object describing the diagnostics"
# }

variable "networking_object" {
  description = "(Required) configuration object describing the networking configuration, as described in README"
}

# variable "subnets" {
#   description = "Map structure for the subnets to be created"
# }

# variable "convention" {
#   description = "(Required) Naming convention method to use"  
# }

# variable "netwatcher" {
#   description = "(Optional) is a map with two attributes: name, rg who describes the name and rg where the netwatcher was already deployed" 
#   default = {}
# }


/*
variable "fw_rg_enabled" {}
# variable "la_rg_enabled" {}

# Network Resource Groups
variable "fw_rg_config" {
  type = object({
    location   = map(string)
    rg_enabled = bool
    rg_name    = map(string)
    tags = object({
      region1 = map(string)
      region2 = map(string)
    })
  })

  default = {
    location   = {}
    rg_enabled = true
    rg_name    = {}
    tags = {
      region1 = {}
      region2 = {}
    }
  }
  description = "Resource Group configuration"
}

# Hub VNet
variable "fw_vnet_config" {
  type = object({
    vnet_name = map(string)
    address_space = object({
      region1 = list(string)
      region2 = list(string)
    })
    base_cidr_block = map(string)
    dns_servers = object({
      region1 = list(string)
      region2 = list(string)
    })
  })

  default = {
    vnet_name = {}
    address_space = {
      region1 = []
      region2 = []
    }
    base_cidr_block = {}
    dns_servers = {
      region1 = []
      region2 = []
    }
  }
  description = "Firewall VNET configuration"
}

variable "fw_subnets" {
  default = [
    {
      name    = ""
      newbits = 0
      number  = 0
    },
    {
      name    = ""
      newbits = 0
      number  = 0
    },
    {
      name    = ""
      newbits = 0
      number  = 0
    },
  ]
}

# Firewall


# VPN Gateway
variable "vnetgw_config" {
  type = object({
    public_ip_name = map(string)
    public_ip_alocation_method = map(string)
    gw_subnet_name = map(string)
    gw_subnet_newbits = map(number)
    gw_subnet_number = map(number)
    gw_name = map(string)
    gw_type = map(string)
    gw_vpn_type = map(string)
    gw_active_active = map(string)
    gw_enable_bgp = map(string)
    gw_sku = map(string)
    gw_ip_configuration_name = map(string)
    gw_ip_configuration_private_ip_allocation_method = map(string)
    gw_ip_configuration_subnet_id = map(string)
  })

  default = {
    public_ip_name = {}
    public_ip_alocation_method = {}
    gw_subnet_name = {}
    gw_subnet_newbits = {}
    gw_subnet_number = {}
    gw_name = {}
    gw_type = {}
    gw_vpn_type = {}
    gw_active_active = {}
    gw_enable_bgp = {}
    gw_sku = {}
    gw_ip_configuration_name = {}
    gw_ip_configuration_private_ip_allocation_method = {}
    gw_ip_configuration_subnet_id = {}
  }
  description = "VPN Gateway configuration"
}

# Zscaler



# NSGs
variable "nsg_config" {
  type = object({
    nsg_name = list(string)
  })

  default = {
    nsg_name = []
  }
}

variable "UntrustSubnet_rules" {
  default = [
    {
    name                       = ""
    priority                   = 100
    direction                  = ""
    access                     = ""
    protocol                   = ""
    source_port_range          = ""
    destination_port_range     = ""
    source_address_prefix      = ""
    destination_address_prefix = ""
    },
  ]
}

variable "TrustedSubnet_rules" {
  default = [
    {
    name                       = ""
    priority                   = 100
    direction                  = ""
    access                     = ""
    protocol                   = ""
    source_port_range          = ""
    destination_port_range     = ""
    source_address_prefix      = ""
    destination_address_prefix = ""
    },
  ]
}

variable "InternalSubnet_rules" {
  default = [
    {
    name                       = ""
    priority                   = 100
    direction                  = ""
    access                     = ""
    protocol                   = ""
    source_port_range          = ""
    destination_port_range     = ""
    source_address_prefix      = ""
    destination_address_prefix = ""
    },
  ]
}

variable "rvdb-sc-ul_rules" {
  default = [
    {
    name                       = ""
    priority                   = 100
    direction                  = ""
    access                     = ""
    protocol                   = ""
    source_port_range          = ""
    destination_port_range     = ""
    source_address_prefix      = ""
    destination_address_prefix = ""
    },
  ]
}

variable "rvdb-sc-dl_rules" {
  default = [
    {
    name                       = ""
    priority                   = 100
    direction                  = ""
    access                     = ""
    protocol                   = ""
    source_port_range          = ""
    destination_port_range     = ""
    source_address_prefix      = ""
    destination_address_prefix = ""
    },
  ]
}
*/
