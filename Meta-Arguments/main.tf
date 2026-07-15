terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0" # Or current 4.x version
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  # Terraform automatically picks up your 'az login' credentials here
}

# Reference the existing KodeKloud Resource Group
data "azurerm_resource_group" "playground" {
  name = "kml_rg_main-8663b72e03404e1f"

}

resource "azurerm_storage_account" "example" {
 
  name                     = "nagashankar0848"
  resource_group_name      = azurerm_resource_group.example.name
  location                 = azurerm_resource_group.example.location # implicit dependency
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}