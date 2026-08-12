variable "name" {
  type        = string
  description = "Name of the Front Door security policy."
}

variable "cdn_frontdoor_profile_id" {
  type        = string
  description = "ID of the CDN Front Door profile."
}

variable "security_policies" {
  type = list(object({
    name = string
    type = string
    settings = object({
      enabled = optional(bool, true)
    })
  }))
  description = "List of security policies."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply."
  default     = {}
}
