variable "display_name" {
  type        = string
  description = "Display name for the application registration."
}

variable "identifier_uris" {
  type        = list(string)
  description = "List of identifier URIs."
  default     = []
}

variable "reply_urls" {
  type        = list(string)
  description = "List of reply URLs."
  default     = []
}

variable "required_resource_access" {
  type        = list(object({ resource_app_id = string, resource_access = list(object({ id = string, type = string })) }))
  description = "List of OAuth2 permissions the application requires from other APIs."
  default     = []
}

variable "owners" {
  type        = list(string)
  description = "List of object IDs of users or groups that own the application."
  default     = []
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply."
  default     = {}
}
