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
}

resource "azurerm_resource_group" "app-rg" {
  name     = "app-rg"
  location = "North Europe"
}

resource "azurerm_network_security_group" "app-nsg" {  
  name                = "app-nsg"
  location            = azurerm_resource_group.app-rg.location
  resource_group_name = azurerm_resource_group.app-rg.name
}

resource "azurerm_virtual_network" "app-vnet" {
  name                = "app-vnet"
  location            = azurerm_resource_group.app-rg.location
  resource_group_name = azurerm_resource_group.app-rg.name
  address_space       = ["10.0.0.0/16"]

  subnet {
    name             = "app-subnet1"
    address_prefixes = ["10.0.1.0/24"]
  }

  subnet {
    name             = "subnet2"
    address_prefixes = ["10.0.2.0/24"]
    security_group   = azurerm_network_security_group.app-nsg.id
  }

}