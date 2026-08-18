resource "azurerm_front_door" "this" {
  name                                         = var.name
  resource_group_name                          = var.resource_group_name
  enforce_backend_pools_certificate_name_check = false
  tags                                         = var.tags

  dynamic "routing_rule" {
    for_each = var.routing_rules
    content {
      name               = routing_rule.value.name
      accepted_protocols = routing_rule.value.accepted_protocols
      patterns_to_match  = routing_rule.value.patterns_to_match
      frontend_endpoints = routing_rule.value.frontend_endpoints
      enabled             = true

      forwarding_configuration {
        backend_pool_name                     = routing_rule.value.forwarding_configuration.backend_pool_name
        cache_enabled                         = routing_rule.value.forwarding_configuration.cache_enabled
        cache_use_dynamic_compression         = routing_rule.value.forwarding_configuration.cache_use_dynamic_compression
        cache_query_string_behavior           = routing_rule.value.forwarding_configuration.cache_query_string_behavior
        cache_query_strings                   = routing_rule.value.forwarding_configuration.cache_query_strings
        forwarded_headers                    = routing_rule.value.forwarding_configuration.forwarded_headers
      }
    }
  }

  dynamic "backend_pool" {
    for_each = var.backend_pools
    content {
      name = backend_pool.value.name

      backend {
        address     = backend_pool.value.backend.address
        http_port   = backend_pool.value.backend.http_port
        https_port  = backend_pool.value.backend.https_port
        host_header = backend_pool.value.backend.host_header
      }

      health_probe_settings {
        name     = backend_pool.value.health_probe_settings.name
        protocol = backend_pool.value.health_probe_settings.protocol
        path     = backend_pool.value.health_probe_settings.path
      }

      load_balancing_settings {
        name = backend_pool.value.load_balancing_settings.name
      }
    }
  }

  dynamic "frontend_endpoint" {
    for_each = var.frontend_endpoints
    content {
      name      = frontend_endpoint.value.name
      host_name = frontend_endpoint.value.host_name
    }
  }

  web_application_firewall_policy_link {
    waf_policy_id = var.waf_policy_link_id
  }
}
