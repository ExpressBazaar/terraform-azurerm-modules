variable "name" {
  type        = string
  description = "Name of the Databricks workspace. 3-64 alphanumeric, hyphens, underscores."

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]{3,64}$", var.name))
    error_message = "Databricks workspace name must be 3-64 alphanumeric characters, hyphens, or underscores."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region for the workspace."
}

variable "sku" {
  type        = string
  description = "SKU of the workspace (Premium, Trial, Standard). Premium required for Unity Catalog."
  default     = "Premium"

  validation {
    condition     = contains(["Premium", "Trial", "Standard"], var.sku)
    error_message = "sku must be Premium, Trial, or Standard."
  }
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed. Disable when using private endpoints."
  default     = false
}

variable "managed_virtual_network_enabled" {
  type        = bool
  description = "Enable managed virtual network for the workspace."
  default     = true
}

variable "customer_managed_key_id" {
  type        = string
  description = "ID of the Key Vault key to use for customer-managed encryption. Leave empty for Microsoft-managed keys."
  default     = null
}

variable "network_security_group_rules" {
  type = list(object({
    name                       = string
    direction                  = string
    access                     = string
    priority                   = number
    protocol                   = string
    source_address_prefix      = string
    destination_address_prefix = string
  }))
  description = "NSG rules to apply to the managed VNet. Leave empty for defaults."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the workspace."
  default     = {}
}
