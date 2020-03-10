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
