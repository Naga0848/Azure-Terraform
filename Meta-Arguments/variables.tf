variable "environment" {
    type = string
    default = "staging"
    description = "the env type or the env name"

}

variable "storage_account_name" {
    type = list(string)
    default = ["nagashankar0848", "nagashankar0849", "nagashankar0850"]
    description = "the storage account name"
}