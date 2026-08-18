variable "name" {
  type        = string
  description = "Name of the Databricks access connector. 3-64 alphanumeric, hyphens, underscores."

  validation {
    condition     = can(regex("^[a-zA-Z0-9_-]{3,64}$", var.name))
    error_message = "Access connector name must be 3-64 alphanumeric characters, hyphens, or underscores."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region for the access connector."
}

variable "identity_type" {
  type        = string
  description = "Type of managed identity (SystemAssigned or UserAssigned)."
  default     = "SystemAssigned"

  validation {
    condition     = contains(["SystemAssigned", "UserAssigned"], var.identity_type)
    error_message = "identity_type must be SystemAssigned or UserAssigned."
  }
}

variable "user_assigned_identity_id" {
  type        = string
  description = "ID of the user-assigned managed identity. Required when identity_type is UserAssigned."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the access connector."
  default     = {}
}
