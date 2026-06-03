variable "name" {
  type        = string
  description = "Name of the network security group."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region for the NSG."
}

variable "rules" {
  type = list(object({
    name                       = string
    priority                   = number
    direction                  = string
    access                     = string
    protocol                   = string
    source_port_range          = optional(string, "*")
    destination_port_range     = optional(string, "*")
    source_address_prefix      = optional(string, "*")
    destination_address_prefix = optional(string, "*")
  }))
  description = "List of security rules to apply to the NSG."
  default     = []
}

variable "subnet_id" {
  type        = string
  description = "Optional subnet ID to associate this NSG with. Leave null to skip association."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the NSG."
  default     = {}
}
