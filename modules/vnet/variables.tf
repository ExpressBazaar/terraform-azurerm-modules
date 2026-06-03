variable "name" {
  type        = string
  description = "Name of the virtual network."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group in which to create the VNet."
}

variable "location" {
  type        = string
  description = "Azure region for the VNet."
}

variable "address_space" {
  type        = list(string)
  description = "List of CIDR blocks for the VNet address space."

  validation {
    condition     = length(var.address_space) > 0
    error_message = "At least one address space CIDR must be provided."
  }
}

variable "dns_servers" {
  type        = list(string)
  description = "Custom DNS servers for the VNet. Leave empty to use Azure-provided DNS."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the VNet."
  default     = {}
}
