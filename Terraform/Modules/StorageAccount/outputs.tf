output "storage_account_id" {
  value       = azurerm_storage_account.storage.id
  description = "The ID of the created storage account."
}

output "storage_account_name" {
  value       = azurerm_storage_account.storage.name
  description = "The name of the created storage account."
}

output "primary_blob_endpoint" {
  value       = azurerm_storage_account.storage.primary_blob_endpoint
  description = "The endpoint URL for blob storage in the primary location."
}

output "primary_blob_host" {
  value       = azurerm_storage_account.storage.primary_blob_host
  description = "The hostname with port for blob storage in the primary location."
}

output "primary_connection_string" {
  value       = azurerm_storage_account.storage.primary_connection_string
  sensitive   = true
  description = "The connection string associated with the primary blob location."
}

output "primary_access_key" {
  value       = azurerm_storage_account.storage.primary_access_key
  sensitive   = true
  description = "The primary access key for the storage account."
}
