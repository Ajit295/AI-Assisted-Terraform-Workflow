variable "no_of_virtual_machines" {
    type = number
    description = "No of virtual machines that we want to create"
    default = 1
}

variable "dbapp_environment" {
  type = map(object({
    server = map(object({
        sku      = string
        dbname = string
      }))

    }))
  }

  variable "webapp_environment" {
  type = map(object({
    serviceplan = map(object({
      sku     = string
      os_type = string
    }))

    serviceapp = map(string)
  }))
}

variable "storage_account_name" {
  type        = string
  description = "The name of the storage account. Must be lowercase alphanumeric characters only and globally unique."
}

variable "storage_account_tier" {
  type        = string
  description = "The storage account tier (Standard or Premium)."
  default     = "Standard"
}

variable "storage_replication_type" {
  type        = string
  description = "The replication type for the storage account (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS)."
  default     = "GRS"
}