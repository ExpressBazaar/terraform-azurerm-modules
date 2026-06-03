variable "name" {
  type        = string
  description = "Name of the subnet."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group (must match the VNet's RG)."
}

variable "vnet_name" {
  type        = string
  description = "Name of the virtual network to attach the subnet to."
}

variable "address_prefixes" {
  type        = list(string)
  description = "List of CIDR blocks for the subnet."

  validation {
    condition     = length(var.address_prefixes) > 0
    error_message = "At least one address prefix must be provided."
  }
}

variable "service_endpoints" {
  type        = list(string)
  description = "List of service endpoints to associate (e.g. Microsoft.Storage)."
  default     = []
}

variable "delegations" {
  type = list(object({
    name         = string
    service_name = string
    actions      = list(string)
  }))
  description = "Optional subnet delegations for managed services."
  default     = []
}
