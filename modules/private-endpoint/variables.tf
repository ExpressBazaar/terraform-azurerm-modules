variable "name" {
  type        = string
  description = "Name of the private endpoint."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "subnet_id" {
  type        = string
  description = "ID of the subnet where the private endpoint will be deployed."
}

variable "target_resource_id" {
  type        = string
  description = "ID of the resource to connect to."
}

variable "private_dns_zone_group_name" {
  type        = string
  description = "Name of the private DNS zone group."
  default     = null
}

variable "private_dns_zone_ids" {
  type        = list(string)
  description = "List of private DNS zone IDs to associate."
  default     = []
}

variable "subresource_names" {
  type        = list(string)
  description = "List of subresource names to connect to (e.g. blob, sql)."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply."
  default     = {}
}
