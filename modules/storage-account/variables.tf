variable "name" {
  type        = string
  description = "Name of the storage account. Globally unique, 3-24 lowercase alphanumeric chars."

  validation {
    condition     = can(regex("^[a-z0-9]{3,24}$", var.name))
    error_message = "Storage account name must be 3-24 lowercase alphanumeric characters."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region for the storage account."
}

variable "account_tier" {
  type        = string
  description = "Performance tier of the storage account."
  default     = "Standard"

  validation {
    condition     = contains(["Standard", "Premium"], var.account_tier)
    error_message = "account_tier must be 'Standard' or 'Premium'."
  }
}

variable "account_replication_type" {
  type        = string
  description = "Replication strategy (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS)."
  default     = "LRS"
}

variable "account_kind" {
  type        = string
  description = "Kind of storage account."
  default     = "StorageV2"
}

variable "min_tls_version" {
  type        = string
  description = "Minimum TLS version for requests."
  default     = "TLS1_2"
}

variable "https_traffic_only_enabled" {
  type        = bool
  description = "Force HTTPS-only traffic."
  default     = true
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed. Disable when using private endpoints."
  default     = false
}

variable "blob_versioning_enabled" {
  type        = bool
  description = "Enable blob versioning."
  default     = true
}

variable "blob_soft_delete_retention_days" {
  type        = number
  description = "Days to retain soft-deleted blobs (1-365)."
  default     = 7
}

variable "containers" {
  type = list(object({
    name        = string
    access_type = optional(string, "private")
  }))
  description = "Blob containers to create within the storage account."
  default     = []
}

variable "network_rules" {
  type = object({
    default_action             = optional(string, "Deny")
    bypass                     = optional(list(string), ["AzureServices"])
    ip_rules                   = optional(list(string), [])
    virtual_network_subnet_ids = optional(list(string), [])
  })
  description = "Network firewall rules for the storage account."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the storage account."
  default     = {}
}
