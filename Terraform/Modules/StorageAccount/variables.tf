variable "storage_account_name" {
  type        = string
  description = "The name of the storage account. Must be lowercase alphanumeric characters only and be globally unique across Azure."
}

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the storage account."
}

variable "location" {
  type        = string
  description = "The Azure region where the storage account will be created."
}

variable "account_tier" {
  type        = string
  description = "Defines the Tier to use for this storage account. Valid options are Standard and Premium."
  default     = "Standard"
}

variable "account_replication_type" {
  type        = string
  description = "Defines the type of replication to use for this storage account. Valid options are LRS, GRS, RAGRS, ZRS, GZRS and RAGZRS."
  default     = "GRS"
}

variable "account_kind" {
  type        = string
  description = "Defines the Kind of account. Valid options are BlobStorage, BlockBlobStorage, FileStorage, Storage and StorageV2."
  default     = "StorageV2"
}

variable "https_traffic_only_enabled" {
  type        = bool
  description = "Whether HTTPS traffic is required. Defaults to true for security."
  default     = true
}

variable "public_network_access_enabled" {
  type        = bool
  description = "Whether the public network access is enabled. Defaults to false for security."
  default     = false
}

variable "min_tls_version" {
  type        = string
  description = "The minimum supported TLS version for the storage account. Valid options are TLS1_0, TLS1_1 and TLS1_2."
  default     = "TLS1_2"
}

variable "shared_access_key_enabled" {
  type        = bool
  description = "Indicates whether the storage account permits requests to be authorized with the account access key via Shared Key."
  default     = true
}

variable "tags" {
  type        = map(string)
  description = "A map of tags to assign to the storage account."
  default     = {}
}
