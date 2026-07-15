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
  subscription_id = "a2b28c85-1948-4263-90ca-bade2bac4df4"  #subscription id of current kodekloud account
  resource_provider_registrations = "none"
  

  #az account show --query id -o tsv   to know the subscription-id
}

# 2. Declare the existing Resource Group using a Data Source
data "azurerm_resource_group" "existing_rg" {
  name = "kml_rg_main-8663b72e03404e1f"
}

resource "azurerm_storage_account" "existing_rg" {
 
  name                     = "day04217061"
  resource_group_name      = data.azurerm_resource_group.existing_rg.name
  location                 = data.azurerm_resource_group.existing_rg.location # implicit dependency
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    environment = "staging"
  }
}