resource "azurerm_web_application_firewall_policy" "this" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location
  mode                = var.mode
  tags                = var.tags

  dynamic "custom_rules" {
    for_each = var.custom_rules
    content {
      name     = custom_rules.value.name
      priority = custom_rules.value.priority
      action   = custom_rules.value.action

      dynamic "match_condition" {
        for_each = custom_rules.value.match_conditions
        content {
          negation_condition = match_condition.value.negation_condition
          transforms         = match_condition.value.transforms

          dynamic "match_variable" {
            for_each = match_condition.value.match_variables
            content {
              variable_name = match_variable.value.variable_name
              operator      = match_variable.value.operator
              match_values  = match_variable.value.match_values
            }
          }
        }
      }
    }
  }

  policy_settings {
    mode                     = var.mode
    request_body_check       = true
    file_upload_limit_mb     = 100
    max_request_body_size_kb = 128
  }

  dynamic "managed_rules" {
    for_each = var.managed_rules != {} ? [var.managed_rules] : []
    content {
      managed_rule_set {
        version = managed_rules.value.managed_rule_set_version
        type    = "Microsoft_BotManagerRuleSet"
      }

      dynamic "exclusion" {
        for_each = managed_rules.value.exclusions
        content {
          match_variable          = exclusion.value.match_variable
          selector_match_operator = exclusion.value.selector_match_operator
          selector                = exclusion.value.selector
        }
      }

      dynamic "override" {
        for_each = managed_rules.value.overrides
        content {
          rule_group_name = override.value.rule_group_name

          dynamic "rule" {
            for_each = override.value.rule
            content {
              rule_id = rule.value.rule_id
              action  = rule.value.action
              enabled = rule.value.enabled
            }
          }
        }
      }
    }
  }
}
