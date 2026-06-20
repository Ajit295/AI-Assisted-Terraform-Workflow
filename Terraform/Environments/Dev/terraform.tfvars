no_of_virtual_machines = 2

dbapp_environment = {
    "production" = {
        server = {
            server895648 = {
                dbname = "appdb"
                sku = "S0"
            }
        }
    }
}

webapp_environment = {
  "production" = {
    serviceplan = {
      serviceplan531665 = {
        sku     = "S1"
        os_type = "Windows"
      }
    }

    serviceapp = {
      webappp54658952 = "serviceplan531665"
    }
  }

  "staging" = {
    serviceplan = {
      serviceplanstage569874 = {
        sku     = "S1"
        os_type = "Windows"
      }
    }

    serviceapp = {
      webapppstage89547 = "serviceplanstage569874"
    }
  }

}

# REQUIRED: Update storage_account_name with your desired storage account name
# Must be globally unique, lowercase alphanumeric characters only
storage_account_name = "poonamstorage23031998"

# Optional: Update storage account tier (Standard or Premium)
storage_account_tier = "Standard"

# Optional: Update replication type (LRS, GRS, RAGRS, ZRS, GZRS, RAGZRS)
storage_replication_type = "LRS"