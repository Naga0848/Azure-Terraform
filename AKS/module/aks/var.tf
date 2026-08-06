variable "location" {

}

variable "existing_rg_name" {
  type        = string
  description = "The name of the existing Azure Resource Group."
  default     = "kml_rg_main-17b80cc4f84444ef" # Optional default value
}


variable "ssh_public_key" {
  default = "~/.ssh/id_rsa.pub"
}


variable "subscription_id" {
  description = "Azure subscription ID for the azurerm provider."
  type        = string
  default     = "a2b28c85-1948-4263-90ca-bade2bac4df4"
}


provider "azurerm" {
  features {}
  subscription_id = var.subscription_id
  resource_provider_registrations = "none"
}