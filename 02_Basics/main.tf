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
  features{}
}

resource "azurerm_resource_group" "test-rg" {
    name = "test-rg"
    location = "North Europe"
  
}

resource "azurerm_storage_account" "teststorage67676" {
  name                     = "teststorage67676"
  resource_group_name      = azurerm_resource_group.test-rg.name
  location                 = azurerm_resource_group.test-rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "scripts" {
  name                  = "scripts"
  storage_account_id    = azurerm_storage_account.teststorage67676.id
}

resource "azurerm_storage_blob" "testps1" {
  name                   = "testps1"
  storage_account_name   = azurerm_storage_account.teststorage67676.name
  storage_container_name = azurerm_storage_container.scripts.name
  type                   = "Block"
  source                 = "testps1" # provide path of the scripts
}