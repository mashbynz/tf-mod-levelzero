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

variable "rt_suffix" {
  description = "(Optional) You can use a suffix to add to the list of Route Tables you want to create"
  type        = string
}
