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