


output "tenant_id" {
  description = "Azure Tenant ID"
  value       = var.create_key_vault ? azurerm_key_vault.this[0].tenant_id : data.azurerm_key_vault.this[0].tenant_id
}

output "subscription_id" {
  description = "Azure subscription ID"
  value       = data.azurerm_subscription.current.subscription_id
}

output "id" {
  description = "The ID of the Key Vault"
  value       = var.create_key_vault ? azurerm_key_vault.this[0].id : data.azurerm_key_vault.this[0].id
}

output "uri" {
  description = "The URI of the Key Vault, used for performing operations on keys and secrets"
  value       = var.create_key_vault ? azurerm_key_vault.this[0].vault_uri : data.azurerm_key_vault.this[0].vault_uri
}

output "name" {
  description = "The name of the Key Vault"
  value       = var.create_key_vault ? azurerm_key_vault.this[0].name : data.azurerm_key_vault.this[0].name
}

output "resource_group" {
  description = "The resource group of the Key Vault"
  value       = data.azurerm_resource_group.this.name
}

output "secrets" {
  description = "List of secrets in key vault"
  value       = flatten([for secret_key, secret in var.secrets : [secret.name]])
}

output "keys" {
  description = "List of keys in key vault"
  value       = flatten([for key_key, key in var.keys : [key.name]])
}

