# Define required provider and its version
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Azure provider configuration
provider "azurerm" {
  features {}
  client_id       = ""
  client_secret   = ""
  subscription_id = ""
  tenant_id       = ""
}