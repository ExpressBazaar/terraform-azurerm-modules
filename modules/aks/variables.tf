variable "name" {
  type        = string
  description = "Name of the AKS cluster."
}

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group."
}

variable "location" {
  type        = string
  description = "Azure region for the cluster."
}

variable "dns_prefix" {
  type        = string
  description = "DNS prefix for the cluster's API server."
}

variable "kubernetes_version" {
  type        = string
  description = "Kubernetes version. Leave null to use the AKS default."
  default     = null
}

variable "sku_tier" {
  type        = string
  description = "Control plane SKU tier (Free, Standard, Premium)."
  default     = "Standard"

  validation {
    condition     = contains(["Free", "Standard", "Premium"], var.sku_tier)
    error_message = "sku_tier must be Free, Standard, or Premium."
  }
}

variable "default_node_pool" {
  type = object({
    name                 = optional(string, "system")
    vm_size              = optional(string, "Standard_D2s_v5")
    node_count           = optional(number, 2)
    auto_scaling_enabled = optional(bool, true)
    min_count            = optional(number, 2)
    max_count            = optional(number, 5)
    vnet_subnet_id       = string
    zones                = optional(list(string), ["1", "2", "3"])
  })
  description = "Configuration for the default (system) node pool."
}

variable "network_plugin" {
  type        = string
  description = "CNI network plugin (azure or kubenet)."
  default     = "azure"
}

variable "network_policy" {
  type        = string
  description = "Network policy engine (azure, calico, or cilium)."
  default     = "calico"
}

variable "service_cidr" {
  type        = string
  description = "CIDR for Kubernetes service IPs. Must not overlap the subnet."
  default     = "172.16.0.0/16"
}

variable "dns_service_ip" {
  type        = string
  description = "IP within service_cidr for cluster DNS."
  default     = "172.16.0.10"
}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics workspace ID for container insights. Null disables monitoring."
  default     = null
}

variable "acr_id" {
  type        = string
  description = "Container registry ID to grant AcrPull. Null skips the role assignment."
  default     = null
}

variable "tags" {
  type        = map(string)
  description = "Tags to apply to the cluster."
  default     = {}
}
