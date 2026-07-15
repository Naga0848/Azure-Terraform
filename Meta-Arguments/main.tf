terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.8.0" # Or current 4.x version
    }
  }
  backend "azurerm" {
  resource_group_name  = "kml_rg_main-8663b72e03404e1f"  # Can be passed via `-backend-config=`"resource_group_name=<resource group name>"` in the `i
  storage_account_name = "day04217061"                      # Can be passed via `-backend-config=`"storage_account_name=<storage accoun
  container_name       = "tfstate"                       # Can be passed via `-backend-config=`"container_name=<container name>"` in t
  key                  = "dev.terraform.tfstate"        # Can be passed via `-backend-config=`"key=<blob key name>"` in the `init` com
}
}

# We have created the storage-account using the backend.sh shell script and using it here. When we run the terraform init command dev.terraform.tfstate will be created in the blob containers  

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
  # Terraform automatically picks up your 'az login' credentials here
}

# 2. Declare the existing Resource Group using a Data Source
data "azurerm_resource_group" "existing_rg" {
  name = "kml_rg_main-8663b72e03404e1f"
}

resource "azurerm_storage_account" "example" {
 
  name                     = "nagashankar0848"
  resource_group_name      = azurerm_resource_group.existing_rg.name
  location                 = azurerm_resource_group.example.location # implicit dependency
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}