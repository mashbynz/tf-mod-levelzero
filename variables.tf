variable "fw_rg_enabled" {}
# variable "la_rg_enabled" {}

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
    tags = object({
      region1 = map(string)
      region2 = map(string)
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
    tags = {
      region1 = {}
      region2 = {}
    }
  }
  description = "Firewall VNET configuration"
}

variable "fw_subnets" {
  default = [
    {
      name    = ""
      newbits = 4
      number  = 1
    },
    {
      name    = ""
      newbits = 4
      number  = 2
    },
    {
      name    = ""
      newbits = 4
      number  = 3
    },
  ]
}
