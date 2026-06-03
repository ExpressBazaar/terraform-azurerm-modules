variable "name" {
  type        = string
  description = "Name of the Linux Web App. Forms part of the default hostname."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "service_plan_name" {
  type        = string
  description = "Name of the App Service Plan to create."
}

variable "sku_name" {
  type        = string
  description = "SKU of the App Service Plan (e.g. B1, P1v3, P2v3)."
  default     = "P1v3"
}

variable "os_type" {
  type        = string
  description = "OS type for the plan."
  default     = "Linux"
}

variable "worker_count" {
  type        = number
  description = "Number of plan workers (instances)."
  default     = 1
}

variable "application_stack" {
  type = object({
    docker_image_name   = optional(string)
    docker_registry_url = optional(string)
    dotnet_version      = optional(string)
    node_version        = optional(string)
    python_version      = optional(string)
  })
  description = "Runtime stack for the web app. Set one runtime."
  default     = {}
}

variable "app_settings" {
  type        = map(string)
  description = "Application settings (environment variables)."
  default     = {}
}

variable "https_only" {
  type        = bool
  description = "Redirect all HTTP traffic to HTTPS."
  default     = true
}

variable "vnet_integration_subnet_id" {
  type        = string
  description = "Subnet ID for regional VNet integration. Null disables integration."
  default     = null
}

variable "minimum_tls_version" {
  type        = string
  description = "Minimum TLS version."
  default     = "1.2"
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply."
  default     = {}
}
