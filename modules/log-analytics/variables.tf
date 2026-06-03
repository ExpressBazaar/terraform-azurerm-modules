variable "name" {
  type        = string
  description = "Name of the Log Analytics workspace."
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
  description = "SKU of the workspace."
  default     = "PerGB2018"
}

variable "retention_in_days" {
  type        = number
  description = "Data retention in days (30-730)."
  default     = 30

  validation {
    condition     = var.retention_in_days >= 30 && var.retention_in_days <= 730
    error_message = "retention_in_days must be between 30 and 730."
  }
}

variable "daily_quota_gb" {
  type        = number
  description = "Daily ingestion cap in GB. -1 means unlimited."
  default     = -1
}

variable "solutions" {
  type = list(object({
    solution_name = string
    publisher     = string
    product       = string
  }))
  description = "Log Analytics solutions to install (e.g. ContainerInsights)."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the workspace."
  default     = {}
}
