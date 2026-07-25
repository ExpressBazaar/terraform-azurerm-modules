variable "name" {
  type        = string
  description = "Name of the user-assigned managed identity. 3-128 chars, alphanumeric, hyphens and underscores."

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9_-]{2,127}$", var.name))
    error_message = "name must be 3-128 characters, starting alphanumeric, and may contain hyphens and underscores."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region for the identity."
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the identity."
  default     = {}
}
