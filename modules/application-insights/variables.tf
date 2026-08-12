variable "name" {
  type        = string
  description = "Name of the Application Insights component."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "workspace_id" {
  type        = string
  description = "ID of the Log Analytics workspace to link."
  default     = null
}

variable "retention_in_days" {
  type        = number
  description = "Retention period in days."
  default     = 30
}

variable "sampling_percentage" {
  type        = number
  description = "Percentage of requests to sample."
  default     = 100
}

variable "disable_ip_masking" {
  type        = bool
  description = "Disable IP masking."
  default     = false
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply."
  default     = {}
}
