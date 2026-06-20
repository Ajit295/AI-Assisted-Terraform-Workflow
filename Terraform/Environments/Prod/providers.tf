terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.19.0"
    }
  }

  backend "azurerm" {
      resource_group_name  = "Terraform-RG"
      storage_account_name = "terraformbackend23091998"
      container_name       = "terraform-state"
      key                  = "terraform.tfstate"
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = ""
}
