variable "server_name" {
  type        = string
  description = "Name of the SQL logical server. Globally unique."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "server_version" {
  type        = string
  description = "Version of the SQL server."
  default     = "12.0"
}

variable "administrator_login" {
  type        = string
  description = "SQL admin username. Omit if using azuread_administrator only."
  default     = null
}

variable "administrator_login_password" {
  type        = string
  description = "SQL admin password. Sensitive. Omit if using azuread_administrator only."
  default     = null
  sensitive   = true
}

variable "azuread_administrator" {
  type = object({
    login_username = string
    object_id      = string
    tenant_id      = optional(string)
  })
  description = "Azure AD administrator for the server. Recommended over SQL auth."
  default     = null
}

variable "minimum_tls_version" {
  type        = string
  description = "Minimum TLS version for the server."
  default     = "1.2"
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether public network access is allowed."
  default     = false
}

variable "databases" {
  type = list(object({
    name           = string
    sku_name       = optional(string, "S0")
    max_size_gb    = optional(number, 32)
    collation      = optional(string, "SQL_Latin1_General_CP1_CI_AS")
    zone_redundant = optional(bool, false)
  }))
  description = "Databases to create on the server."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply."
  default     = {}
}
