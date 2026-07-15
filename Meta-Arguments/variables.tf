variable "environment" {
    type = string
    default = "staging"
    description = "the env type or the env name"

}

variable "storage_account_name" {
    type = string
    default = "mystorageaccount"
    description = "the name of the storage account"
}

