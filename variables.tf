variable "resource_groups" {
  description = "(Required) Map of the Resource Groups to create"
}

# Example of resource_groups data structure:
# resource_groups = {
#   apim = {
#     name     = "-apim-demo"
#     location = "southeastasia"
#   },
#   networking = {
#     name     = "-networking-demo"
#     location = "southeastasia"
#   },
#   insights = {
#     name     = "-insights-demo"
#     location = "southeastasia"
#     tags = {
#       project  = "Pattaya"
#       approver = "Gunter"
#     }
#   },
# }

variable "rg_suffix" {
  description = "(Optional) You can use a suffix to add to the list of Resource Groups you want to create"
}

variable "tags" {
  default     = ""
  description = "(Required) tags for the deployment"
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

variable "nsg_suffix" {
  description = "(Optional) You can use a suffix to add to the Network Security Groups you want to create"
  type        = string
}

variable "vnet_suffix" {
  description = "(Optional) You can use a suffix to add to the list of Virtual Networks you want to create"
  type        = string
}

# variable "route_tables" {
#   description = "(Required) Map of the Route Tables to create"
# }

# Example of resource_groups data structure:
# route_table = {
#   name                          = "route_test"
#   rg                            = "uqvh-HUB-CORE-NET"
#   location                      = "southeastasia"
#   disable_bgp_route_propagation = false #optional
#   route_entries = {
#     re1 = {
#       name          = "myroute1"
#       prefix        = "255.0.0.0/8"
#       next_hop_type = "None"
#     },
#     re2 = {
#       name                   = "myroute2"
#       prefix                 = "255.255.0.0/16"
#       next_hop_type          = "VirtualAppliance"
#       next_hop_in_ip_address = "192.168.10.5" #required if next_hop_type is "VirtualAppliance"
#     },
#     re3 = {
#       name                   = "defaulroute"
#       prefix                 = "0.0.0.0/0"
#       next_hop_type          = "VirtualAppliance"
#       next_hop_in_ip_address = "192.168.10.5" #required if next_hop_type is "VirtualAppliance"
#     },
#   }
# }

variable "rt_suffix" {
  description = "(Optional) You can use a suffix to add to the list of Route Tables you want to create"
  type        = string
}
