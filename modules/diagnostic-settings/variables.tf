variable "name" {
  type        = string
  description = "Name of the diagnostic setting."
}

variable "target_resource_id" {
  type        = string
  description = "ID of the resource to send diagnostics from."
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "ID of the Log Analytics workspace."
  default     = null
}

variable "storage_account_id" {
  type        = string
  description = "ID of the storage account."
  default     = null
}

variable "eventhub_namespace_id" {
  type        = string
  description = "ID of the Event Hub namespace."
  default     = null
}

variable "eventhub_policy_name" {
  type        = string
  description = "Name of the Event Hub policy."
  default     = null
}

variable "logs" {
  type = list(object({
    category       = string
    retention_days = optional(number, 0)
  }))
  description = "List of log categories to enable."
  default     = []
}

variable "metrics" {
  type = list(object({
    category = string
    enabled  = optional(bool, true)
  }))
  description = "List of metric categories to enable."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply."
  default     = {}
}
