output "key_vault_uri" {
  value = module.key_vault.vault_uri
}

output "storage_blob_endpoint" {
  value = module.storage.primary_blob_endpoint
}

output "log_analytics_id" {
  value = module.log_analytics.id
}
