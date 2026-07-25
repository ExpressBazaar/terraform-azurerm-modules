variable "name" {
  type        = string
  description = "Name of the Application Insights instance. 1-260 chars, alphanumeric, hyphens, underscores and periods."

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9._-]{0,259}$", var.name))
    error_message = "name must be 1-260 characters, starting alphanumeric, and may contain hyphens, underscores and periods."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region for the Application Insights instance."
}

variable "application_type" {
  type        = string
  description = "Type of application being monitored."
  default     = "web"

  validation {
    condition     = contains(["web", "java", "MobileCenter", "Node.JS", "other", "phone", "store", "ios"], var.application_type)
    error_message = "application_type must be one of web, java, MobileCenter, Node.JS, other, phone, store, ios."
  }
}

variable "workspace_id" {
  type        = string
  description = "ID of the Log Analytics workspace to back this instance (workspace-based mode). Recommended; classic mode is retired."
  default     = null
}

variable "retention_in_days" {
  type        = number
  description = "Data retention in days. Valid values: 30, 60, 90, 120, 180, 270, 365, 550, 730."
  default     = 90

  validation {
    condition     = contains([30, 60, 90, 120, 180, 270, 365, 550, 730], var.retention_in_days)
    error_message = "retention_in_days must be one of 30, 60, 90, 120, 180, 270, 365, 550, 730."
  }
}

variable "sampling_percentage" {
  type        = number
  description = "Percentage of telemetry to sample (0-100). 100 means no sampling."
  default     = 100

  validation {
    condition     = var.sampling_percentage >= 0 && var.sampling_percentage <= 100
    error_message = "sampling_percentage must be between 0 and 100."
  }
}

variable "daily_data_cap_in_gb" {
  type        = number
  description = "Daily data volume cap in GB. Null uses the Azure default."
  default     = null
}

variable "disable_ip_masking" {
  type        = bool
  description = "Whether client IP addresses are stored without masking. Disable only if you need full IPs."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the Application Insights instance."
  default     = {}
}
