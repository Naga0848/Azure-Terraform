terraform {
  required_providers {
    azurerm = {
        source = "hashicorp/azurerm"
        version = "~> 4.8.0"
    }
  }

  required_version = ">=1.9.0"
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
    
  features {}
  subscription_id = "96cef66f-6f2e-4cd7-9b71-7364db48c083"  # subscription id of current kodekloud account
   resource_provider_registrations = "none"
  # "skip_provider_registration" is deprecated and removed; allow the provider to register resource providers automatically.
  }

#az account show --query id -o tsv   to know the subscription-id