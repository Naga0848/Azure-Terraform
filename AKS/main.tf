terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.8.0"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.0"
    }
  }
  required_version = ">=1.9.0"
}

provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
}

# Declare the existing Resource Group using a Data Source
data "azurerm_resource_group" "existing_rg" {
  name = "kml_rg_main-17b80cc4f84444ef"
}

module "aks" {
  source            = "./module/aks"
  location          = data.azurerm_resource_group.existing_rg.location
  existing_rg_name  = data.azurerm_resource_group.existing_rg.name
  ssh_public_key    = "~/.ssh/id_rsa.pub"
}

resource "local_file" "kubeconfig" {
  depends_on = [module.aks]
  filename   = "./kubeconfig"
  content    = module.aks.config
}

variable "subscription_id" {
  description = "Azure subscription ID for the azurerm provider."
  type        = string
}
