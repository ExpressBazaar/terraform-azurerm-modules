variable "name" {
  type        = string
  description = "Name of the WAF policy."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region."
}

variable "mode" {
  type        = string
  description = "Operational mode (Prevention or Detection)."
  default     = "Prevention"
}

variable "managed_rules" {
  type = object({
    managed_rule_set_version = optional(string, "3.2")
    exclusions = optional(list(object({
      match_variable          = string
      selector_match_operator = string
      selector                = string
    })), [])
    overrides = optional(list(object({
      rule_group_name = string
      rule = optional(list(object({
        rule_id  = string
        action   = string
        enabled  = optional(bool, true)
      })), [])
    })), [])
  })
  description = "Managed rule configuration."
  default     = {}
}

variable "custom_rules" {
  type = list(object({
    name     = string
    priority = number
    action   = string
    match_conditions = list(object({
      match_variables = list(object({
        variable_name = string
        operator      = string
        match_values  = list(string)
      }))
      negation_condition = optional(bool, false)
      transforms         = optional(list(string), [])
    })
  }))
  description = "List of custom rules."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply."
  default     = {}
}
