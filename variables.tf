
variable "create_key_vault" {
  description = "Create Key Vault"
  type        = bool
  default     = false
}

variable "name" {
  description = "Key Vault Name or name of existing key vault"
  type        = string
}

variable "resource_group" {
  description = "The name of the resource group in which to create the Key Vault."
  type        = string
}

variable "tenant_id" {
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
  type        = string
  default     = null
}

variable "sku_name" {
  description = "The Azure Active Directory tenant ID that should be used for authenticating requests to the key vault."
  type        = string
  default     = "standard"
}

variable "location" {
  description = "Specifies the supported Azure location where the resource exists."
  type        = string
  default     = null
}

variable "access_policy" {
  description = <<EOT
    A list of up to 16 objects describing access policies.
    tenant_id: will default to tenant of current user credentals
    object_id: will default to object ID of current user.
    application_id: optional
    certificate_permissions: Backup, Create, Delete, DeleteIssuers, Get, GetIssuers, Import, List, ListIssuers, ManageContacts, ManageIssuers, Purge, Recover, Restore, SetIssuers, Update.
    key_permissions: Backup, Create, Decrypt, Delete, Encrypt, Get, Import, List, Purge, Recover, Restore, Sign, UnwrapKey, Update, Verify, WrapKey.
    secret_permissions: Backup, Delete, Get, List, Purge, Recover, Restore, Set.
    storage_permissions: Backup, Delete, DeleteSAS, Get, GetSAS, List, ListSAS, Purge, Recover, RegenerateKey, Restore, Set, SetSAS Update.
  EOT
  type = list(object({
    tenant_id               = string
    object_id               = string
    application_id          = string
    certificate_permissions = list(string)
    key_permissions         = list(string)
    secret_permissions      = list(string)
    storage_permissions     = list(string)
  }))
  default = []
}

variable "purge_protection_enabled" {
  description = "Specifies the supported Azure location where the resource exists.."
  type        = bool
  default     = false
}

variable "soft_delete_retention_days" {
  description = "Days to retain secrets after soft deletion."
  type        = number
  default     = 30
}

variable "secrets" {
  description = "A list of secrets to create."
  type = list(object({
    name         = string
    value        = string
    content_type = string
  }))
  default = []
}

variable "keys" {
  description = "A list of keys to create."
  type = list(object({
    name = string
    type = string
    size = number
  }))
  default = []
}
