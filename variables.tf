variable "fw_vnet_enabled" {}
variable "fw_rg_enabled" {}
variable "la_rg_enabled" {}
variable "level1_network_location" {}
variable "level1_network_resource_group_name" {}

variable "fw_vnet_config" {
  type = object({
    location     = map(string)
    vnet_enabled = bool
    address_space = object({
      ae  = list(string)
      ase = list(string)
    })
    vnet_name     = map(string)
    subnet_name   = map(string)
    subnet_prefix = map(string)
    dns_servers = object({
      ae  = list(string)
      ase = list(string)
    })
    tags = object({
      ae  = map(string)
      ase = map(string)
    })
  })

  default = {
    location     = {}
    vnet_enabled = true
    address_space = {
      ae  = []
      ase = []
    }
    vnet_name     = {}
    subnet_name   = {}
    subnet_prefix = {}
    dns_servers = {
      ae  = []
      ase = []
    }
    tags = {
      ae  = {}
      ase = {}
    }
  }
  description = "Firewall VNET configuration"
}
