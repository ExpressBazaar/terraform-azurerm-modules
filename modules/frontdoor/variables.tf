variable "name" {
  type        = string
  description = "Name of the Front Door."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "routing_rules" {
  type = list(object({
    name               = string
    accepted_protocols = list(string)
    patterns_to_match  = list(string)
    frontend_endpoints = list(string)
    forwarding_configuration = object({
      backend_pool_name                     = string
      cache_enabled                         = optional(bool, false)
      cache_use_dynamic_compression         = optional(bool, false)
      cache_query_string_behavior           = optional(string, "IncludeAllNamedQueryStrings")
      cache_query_strings                   = optional(list(string), [])
      forwarded_headers                    = optional(list(string), ["RequestHeader"])
    }
  }))
  description = "List of routing rules."
  default     = []
}

variable "backend_pools" {
  type = list(object({
    name = string
    backend = object({
      address     = string
      http_port   = optional(number, 80)
      https_port  = optional(number, 443)
      host_header = string
    }
    health_probe_settings = object({
      name     = string
      protocol = optional(string, "Https")
      path     = optional(string, "/")
    })
    load_balancing_settings = object({
      name = string
    })
  }))
  description = "List of backend pools."
  default     = []
}

variable "frontend_endpoints" {
  type = list(object({
    name      = string
    host_name = string
  }))
  description = "List of frontend endpoints."
  default     = []
}

variable "waf_policy_link_id" {
  type        = string
  description = "ID of the WAF policy to link."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply."
  default     = {}
}
