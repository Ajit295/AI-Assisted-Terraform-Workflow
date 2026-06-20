resource "azurerm_service_plan" "ajitserviceplan2954" {
  name                = "ajitserviceplan2954"
  resource_group_name = var.resource_group_name
  location            = var.location
  os_type             = "Linux"
  sku_name            = "P0v3"
}

resource "azurerm_linux_web_app" "ajitwebapp2954" {
  name                = "ajitwebapp2954"
  resource_group_name = var.resource_group_name
  location            = var.location
  service_plan_id     = azurerm_service_plan.ajitserviceplan2954.id

  site_config {
    application_stack {
      python_version = "3.12"
    }
  }
  depends_on = [azurerm_service_plan.ajitserviceplan2954]
}

# resource "azurerm_app_service_source_control" "ajitwebapp2954_scm" {
#   app_id   = azurerm_linux_web_app.ajitwebapp2954.id
#   repo_url = "https://github.com/Ajit295/python-flask.git"
#   branch   = "main"
# }

resource "azurerm_linux_web_app_slot" "ajitwebapp2954_slot" {
  name           = "stage"
  app_service_id = azurerm_linux_web_app.ajitwebapp2954.id
  site_config {}

  depends_on = [azurerm_linux_web_app.ajitwebapp2954]
}

# resource "azurerm_app_service_source_control_slot" "ajitwebapp2954_slot_scm" {
#   slot_id  = azurerm_linux_web_app_slot.ajitwebapp2954_slot.id
#   repo_url = "https://github.com/Ajit295/python-flask.git"
#   branch   = "Pre-Prod"
#   depends_on = [azurerm_linux_web_app_slot.ajitwebapp2954_slot]
# }
