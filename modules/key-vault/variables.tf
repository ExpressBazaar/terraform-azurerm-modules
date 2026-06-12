variable "name" {
  type        = string
  description = "Name of the Key Vault. Must be globally unique, 3-24 alphanumeric chars."

  validation {
    condition     = can(regex("^[a-zA-Z][a-zA-Z0-9-]{1,22}[a-zA-Z0-9]$", var.name))
    error_message = "Key Vault name must be 3-24 chars, alphanumeric and hyphens, starting with a letter."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region for the Key Vault."
}

variable "tenant_id" {
  type        = string
  description = "Azure AD tenant ID for the Key Vault."
}

variable "sku_name" {
  type        = string
  description = "SKU of the Key Vault."
  default     = "standard"
}

variable "enable_rbac_authorization" {
  type        = bool
  description = "Use Azure RBAC instead of access policies for data plane permissions."
  default     = true
}

variable "purge_protection_enabled" {
  type        = bool
  description = "Enable purge protection. Strongly recommended for production."
  default     = false
}

variable "soft_delete_retention_days" {
  type        = number
  description = "Days that soft-deleted items are retained (7-90)."
  default     = 7

  validation {
    condition     = var.soft_delete_retention_days >= 7 && var.soft_delete_retention_days <= 90
    error_message = "soft_delete_retention_days must be between 7 and 90."
  }
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed. Disable when using private endpoints."
  default     = false
}

variable "network_acls" {
  type = object({
    default_action             = optional(string, "Deny")
    bypass                     = optional(string, "AzureServices")
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
  })
  description = "Network ACL rules for the Key Vault firewall."
  default     = {}
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Key Vault."
  default     = {}
}
