resource "azurerm_cdn_frontdoor_security_policy" "this" {
  name                     = var.name
  cdn_frontdoor_profile_id = var.cdn_frontdoor_profile_id

  dynamic "security_policies" {
    for_each = var.security_policies
    content {
      name     = security_policies.value.name
      type     = security_policies.value.type
      settings = security_policies.value.settings
    }
  }
}
