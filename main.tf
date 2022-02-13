locals {

}

data "azurerm_subscription" "current" {}

data "azurerm_client_config" "current" {}

data "azurerm_resource_group" "this" {
  name = var.resource_group
}

data "azurerm_key_vault" "this" {
  count               = var.create_key_vault ? 0 : 1
  name                = var.name
  resource_group_name = data.azurerm_resource_group.this.name
}


resource "azurerm_key_vault" "this" {
  count                       = var.create_key_vault ? 1 : 0
  name                        = var.name
  location                    = var.location == null ? data.azurerm_resource_group.this.location : var.location
  resource_group_name         = data.azurerm_resource_group.this.name
  enabled_for_disk_encryption = true
  tenant_id                   = var.tenant_id == null ? data.azurerm_client_config.current.tenant_id : var.tenant_id
  soft_delete_retention_days  = var.soft_delete_retention_days
  purge_protection_enabled    = var.purge_protection_enabled
  sku_name                    = var.sku_name

  dynamic "access_policy" {
    for_each = var.access_policy
    iterator = policy
    content {
      tenant_id = policy.value.tenant_id == null ? data.azurerm_client_config.current.tenant_id : policy.value.tenant_id
      object_id = policy.value.object_id == null ? data.azurerm_client_config.current.object_id : policy.value.object_id

      certificate_permissions = policy.value.certificate_permissions
      key_permissions         = policy.value.key_permissions
      secret_permissions      = policy.value.secret_permissions
      storage_permissions     = policy.value.storage_permissions

    }
  }
}

resource "azurerm_key_vault_secret" "this" {
  count        = length(var.secrets)
  name         = var.secrets[count.index].name
  value        = var.secrets[count.index].value
  key_vault_id = var.create_key_vault ? azurerm_key_vault.this[0].id : data.azurerm_key_vault.this[0].id
}

resource "azurerm_key_vault_key" "this" {
  count        = length(var.keys)
  name         = var.keys[count.index].name
  key_type     = var.keys[count.index].type
  key_size     = var.keys[count.index].size
  key_vault_id = var.create_key_vault ? azurerm_key_vault.this[0].id : data.azurerm_key_vault.this[0].id
  key_opts = [
    "decrypt",
    "encrypt",
    "sign",
    "unwrapKey",
    "verify",
    "wrapKey",
  ]
}
