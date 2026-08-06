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


variable "client_id" {}
variable "client_secret" {
  type = string
  sensitive = true
}