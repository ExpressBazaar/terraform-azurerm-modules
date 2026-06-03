variable "name" {
  type        = string
  description = "Name of the container registry. Globally unique, 5-50 alphanumeric chars."

  validation {
    condition     = can(regex("^[a-zA-Z0-9]{5,50}$", var.name))
    error_message = "ACR name must be 5-50 alphanumeric characters (no hyphens)."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region for the registry."
}

variable "sku" {
  type        = string
  description = "SKU of the registry (Basic, Standard, Premium). Premium required for private endpoints."
  default     = "Premium"

  validation {
    condition     = contains(["Basic", "Standard", "Premium"], var.sku)
    error_message = "sku must be Basic, Standard, or Premium."
  }
}

variable "admin_enabled" {
  type        = bool
  description = "Enable the admin user. Discouraged; use managed identity / RBAC instead."
  default     = false
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed."
  default     = false
}

variable "georeplications" {
  type = list(object({
    location                = string
    zone_redundancy_enabled = optional(bool, true)
  }))
  description = "Geo-replication locations (Premium SKU only)."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the registry."
  default     = {}
}
