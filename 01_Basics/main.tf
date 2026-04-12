terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.68.0"
    }
  }
}

provider "azurerm" {
  # Configuration options
  features {}
  subscription_id = "863c6b2b-405d-4f6d-8905-bc6c04102f27"
}

resource "azurerm_resource_group" "name" {
  name = "first_rg"
  location = "North Europe"
}