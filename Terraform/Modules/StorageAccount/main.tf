resource "azurerm_storage_account" "storage" {
  name                     = var.storage_account_name
  resource_group_name      = var.resource_group_name
  location                 = var.location
  account_tier             = var.account_tier
  account_replication_type = var.account_replication_type
  account_kind             = var.account_kind

  https_traffic_only_enabled  = var.https_traffic_only_enabled
  public_network_access_enabled = var.public_network_access_enabled
  min_tls_version             = var.min_tls_version
  shared_access_key_enabled   = var.shared_access_key_enabled

  tags = var.tags
}
