resource "azuread_application" "this" {
  display_name            = var.display_name
  identifier_uris         = var.identifier_uris
  reply_urls              = var.reply_urls
  required_resource_access = var.required_resource_access
  tags                    = var.tags
}

resource "azuread_service_principal" "this" {
  application_id = azuread_application.this.application_id
}

resource "azuread_service_principal_password" "this" {
  service_principal_id = azuread_service_principal.this.id
  end_date_relative    = "8760h"
}
