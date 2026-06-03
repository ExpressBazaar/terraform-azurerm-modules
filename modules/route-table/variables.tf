variable "name" {
  type        = string
  description = "Name of the route table."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region for the route table."
}

variable "bgp_route_propagation_enabled" {
  type        = bool
  description = "Whether BGP route propagation is enabled."
  default     = true
}

variable "routes" {
  type = list(object({
    name                   = string
    address_prefix         = string
    next_hop_type          = string
    next_hop_in_ip_address = optional(string)
  }))
  description = "List of routes for the route table."
  default     = []
}

variable "subnet_id" {
  type        = string
  description = "Optional subnet ID to associate this route table with. Leave null to skip."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the route table."
  default     = {}
}
