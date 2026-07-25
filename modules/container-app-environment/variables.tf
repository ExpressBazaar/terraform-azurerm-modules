variable "name" {
  type        = string
  description = "Name of the Container App Environment. 2-32 chars, lowercase alphanumeric and hyphens."

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{0,30}[a-z0-9]$", var.name))
    error_message = "name must be 2-32 lowercase alphanumeric characters or hyphens, starting and ending alphanumeric."
  }
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region for the environment."
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "ID of the Log Analytics workspace to send container logs to."
  default     = null
}

variable "infrastructure_subnet_id" {
  type        = string
  description = "ID of the subnet to inject the environment into. Required for internal load balancer / VNet integration."
  default     = null
}

variable "internal_load_balancer_enabled" {
  type        = bool
  description = "Whether the environment uses an internal (private) load balancer. Requires infrastructure_subnet_id."
  default     = false
}

variable "zone_redundancy_enabled" {
  type        = bool
  description = "Whether the environment is zone redundant. Requires infrastructure_subnet_id."
  default     = false
}

variable "workload_profiles" {
  type = list(object({
    name                  = string
    workload_profile_type = string
    minimum_count         = number
    maximum_count         = number
  }))
  description = "Workload profiles for the environment (e.g. Consumption, Dedicated D4). Empty for a Consumption-only environment."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the environment."
  default     = {}
}
