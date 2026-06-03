variable "name" {
  type        = string
  description = "Name of the private DNS zone (e.g. privatelink.vaultcore.azure.net)."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "virtual_network_links" {
  type = list(object({
    name                 = string
    virtual_network_id   = string
    registration_enabled = optional(bool, false)
  }))
  description = "VNet links so resources in those VNets resolve records in this zone."
  default     = []
}

variable "a_records" {
  type = list(object({
    name    = string
    ttl     = optional(number, 300)
    records = list(string)
  }))
  description = "A records to create in the zone."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the zone."
  default     = {}
}
