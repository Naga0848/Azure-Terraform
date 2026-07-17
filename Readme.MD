### This is a global readme repo consists of Azure Terraform related info

### Basic commands to be followed in order to create a repo or a file and push it into GitHub

    First create the necessary folder inside the vscode

    open terminal ---> cd folder name
	
	git init

    git branch -M main (switching from master to main branch)

    git remote add origin <repo url>  (which we have created in the GitHub for our repo)

    git add . ; git commit -m "commit message" ; git push origin master    (change the branch name accordingly)

terraform documentation https://developer.hashicorp.com/terraform/docs


### Commands to perform in order to connect to the azure account

    az login

    give the mail id of the account to which we have the azure account

    enter the code which you have received in the concerned email inbox

    The authentication is successful

    below is the screenshot and the output which we receive after running the az login command and the output displays the subscriptionid

![alt text](Images/az-login.png)



    Select the account you want to log in with. For more information on login with Azure CLI, see https://go.microsoft.com/fwlink/?linkid=2271136

    Retrieving tenants and subscriptions for the selection...

    [Tenant and subscription selection]

    No     Subscription name     Subscription ID                       Tenant
    -----  --------------------  ------------------------------------  -----------------
    [1] *  Azure subscription 1  c0b3d310-9949-4aeb-a1cf-357af87c1e20  Default Directory

    The default is marked with an *; the default tenant is 'Default Directory' and subscription is 'Azure subscription 1' (c0b3d310-9949-4aeb-a1cf-357af87c1e20).

    Select a subscription and tenant (Type a number or Enter for no changes):

    Tenant: Default Directory
    Subscription: Azure subscription 1 (c0b3d310-9949-4aeb-a1cf-357af87c1e20)

    [Announcements]
    With the new Azure CLI login experience, you can select the subscription you want to use more easily. Learn more about it and its configuration at
    https://go.microsoft.com/fwlink/?linkid=2271236

    If you encounter any problem, please open an issue at https://aka.ms/azclibug

    [Warning] The login output has been updated. Please be aware that it no longer displays the full list of available subscriptions by default.


### Authentication to Azure Portal or Resources Provisioning

    * An Azure service principal is a non-human identity in Microsoft Entra ID used by applications, services, and automated tools to access specific Azure resources.

    * We have to create a service principle inorder to create the resources in Azure portal 
    rather than using our own credentials by assigning the contributor role to it.

    * command to create the service principle

        az ad sp create-for-rbac -n az-naga --role="Contributor" --scopes="/subscriptions/c0b3d310-9949-4aeb-a1cf-357af87c1e20"

    * After creating the service-principle we get the below message 

![alt text](Images/service-principle.png)

     az ad sp create-for-rbac -n az-naga --role="Contributor" --scopes="//subscriptions/c0b3d310-9949-4aeb-a1cf-357af87c1e20"

    Found an existing application instance: (id) 234916a2-6b03-43f7-a6f2-43f62685f7ca. We will patch it.
    Creating 'Contributor' role assignment under scope '//subscriptions/c0b3d310-9949-4aeb-a1cf-357af87c1e20'
    The output includes credentials that you must protect. Be sure that you do not include these credentials in your code or check the credentials into your source control. For more information, see https://aka.ms/azadsp-cli
    {
    "appId": "19019e6e-dc66-447c-9406-71f18a90b32c",
    "displayName": "az-naga",
    "password": "au48Q~ldOyUved6O_NREU3MVJeZV6l88O8LBXbPR",
    "tenant": "daab0a0f-c83d-4ab1-93bf-1e2f6645c8be"
    }


    * Now inorder to authenticate with azure account using service principle we have to define the env variables and use the above mentioned passwords

        export ARM_CLIENT_ID="19019e6e-dc66-447c-9406-71f18a90b32c"
        export ARM_CLIENT_SECRET="au48Q~ldOyUved6O_NREU3MVJeZV6l88O8LBXbPR"
        export ARM_SUBSCRIPTION_ID="c0b3d310-9949-4aeb-a1cf-357af87c1e20"
        export ARM_TENANT_ID="daab0a0f-c83d-4ab1-93bf-1e2f6645c8be"

![alt text](Images/set-env-vars.png)


### Time to execute the terraform commands to create the resources mentioned in main.tf files

    terraform init

    terraform plan

    terraform validate

    terraform apply -auto-approve

    * Now the resources like resource_group with the name "nagashankar" and a storage_account with the name "nagashankar0848" will be created in the azure account as shown in the below screenshots

![alt text](Images/resource-group.png)

    * Now a .terraform file and .terraform.lock.hcl are created using which terraform talks to azure apis and creates the 
    necessary resources mentioned in main.tf file

![alt text](Images/storage-account.png)

    

### Understanding Statefile

    * We just create something called backend in the terraform code inorder to store our statefile.

    * The statefile gets stored in the storage account(which is not managed by the terraform at all)

    * We directly create it using the shell scripting i.e., backend.sh

    * After creating the storage-account, we need to mention a block of code in main.tf with the name backend to inform terraform to store the statefile inside that staorage-account.

    * get inside the folder where the bash script is located

    * chmod 775 backend.sh

    * ./backend.sh    # command to execute the shell script to create the resource-group and storage account for storing statefile

    * az storage container create --name <YOUR_CONTAINER_NAME> --account-name nagastatefile --auth-mode login

        please run the above command when the statefile is not created in the KodeKloud azure account

![alt text](Images/statefile-resource-group.png)


    * Now a storage accound within this resource group will be created which is not managed by terraform and the statefile is stored in it.

![alt text](Images/statefile-storage-account.png)

    * Now to run the terraform commands to see the statefile creation in our staorage account

        terraform init

        terraform plan

        terraform validate

        terraform apply -auto-approve

![alt text](Images/statefile.png)       

    * Finally we can see that statefile is created inside our storage account

    * Remember that we have created a block inside our main.tf for the statefile creation in remote 

    * Below is the general storage account created from main.tf

![alt text](Images/general-storage-account.png)    

    * Below is the general resource-group created from main.tf

![alt text](Images/general-resource-group.png)

    * Remember that statefile gets stored in the another storage account which we created using the bakend block in main.tf

    * After practising do not forget to delete the resource group which we created for statefile.

### Steps to be followed to login to azure account created in KodeKloud

    az login

    select the Work or school account as shown in the below image as KodeKloud credentials are valid only for this account.

![alt text](Images/KodeKloud.png)

    use the IAM username and Password to login to the KodeKloud provided azure account.

    Also make sure to copy the subscriptionID in order to create the service principle to create the azure resources in the KodeKloud provided azure account. Please refer the below image.

![alt text](Images/KodeKloud-subscriptionid.png)    

    Make sure to use the default resource-group provided in the KodeKloud provided azure account in order to create the resources as shown below

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


        * Now use the above template in main.tf and start creating the resources

        * Understand that you cannot create a service principle here in order to create the resources as we are using a basic student account

        * Inorder to create the statefile, please run the below commands

        * chmod 775 backend.sh

        * ./backend.sh    # command to execute the shell script to create the resource-group and storage account for storing statefile

        * By now we have created the storage-account using the backend.sh shell script and using it here. When we run the terraform init command dev.terraform.tfstate will be created in the blob containers as shown below

![alt text](Images/kodekloud-statefile.png)

        * And we are referring this storage-accound in the main.tf file so that the statefile is accessed in this location by terraform

        * az account show --query id -o tsv   to know the subscription-id

        * Why "none" fixes your KodeKloud error
        Registering a Resource Provider requires high-level subscription administrative permissions (specifically the */register/action permission).

        * Because you are using a restricted student account in a KodeKloud sandbox, you do not have administrative access to the entire subscription. When Terraform attempts to register those providers, Azure blocks it and throws a 403 Forbidden error.

        * skip_provider_registration = true completely skips that automatic registration scan. Terraform will simply assume that the core services you need (like basic Networking and Storage) are already pre-registered by the KodeKloud administrators, allowing your code to execute smoothly without hitting permission blocks.

        * Look at the below image to understand more about Azure Resource Provider

![alt text](Images/azure-resource-provider.png)        


#### when you are facing issue with the vscode editor

    * Follow the steps

    * Open settings using Ctrl + , (comma).

    * Now search for settings.json and replace it with the below code

        {
    "workbench.colorTheme": "Monokai",
    "editor.fontSize": 18,
    "window.zoomLevel": 1,
    "files.autoSave": "afterDelay",
    "vs-kubernetes": {
        "vscode-kubernetes.minikube-path-windows": "C:\\Users\\user\\.vs-kubernetes\\tools\\minikube\\windows-amd64\\minikube.exe",
        "vscode-kubernetes.helm-path-windows": "C:\\Users\\user\\.vs-kubernetes\\tools\\helm\\windows-amd64\\helm.exe",
        "vscode-kubernetes.kubectl-path-windows": "C:\\Users\\user\\.vs-kubernetes\\tools\\kubectl\\kubectl.exe"
    },
    "editor.columnSelection": true,
    "editor.acceptSuggestionOnEnter": "on",
    "editor.quickSuggestions": {
        "other": "on",
        "comments": "on",
        "strings": "on"
    },
    "editor.snippetSuggestions": "top",
    "editor.inlineSuggest.enabled": true,
    "[dockercompose]": {
        "editor.insertSpaces": true,
        "editor.tabSize": 2,
        "editor.autoIndent": "advanced",
        "editor.quickSuggestions": {
            "other": "on",
            "comments": "on",
            "strings": "on"
        },
        "editor.defaultFormatter": "redhat.vscode-yaml"
    },
    "[github-actions-workflow]": {
        "editor.defaultFormatter": "redhat.vscode-yaml"
    },
    "security.workspace.trust.untrustedFiles": "open",
    "azureTerraform.survey": {
        "surveyPromptDate": "2026-07-16T11:06:28.756Z",
        "surveyPromptIgnoredCount": 0
    },
    "gitlens.ai.model": "vscode",
    "gitlens.ai.vscode.model": "copilot:gpt-4o-mini"
}

### Understanding Terraform Meta Arguments   ---> https://developer.hashicorp.com/terraform/language/meta-arguments


![alt text](Images/meta-arguments.png)

    ### Understanding Count

        * Lets use the storage-account as an example to know about count.

        * we all know that we cannot create the storage-account with same names, i.e., the names should be unique

        * If we want to create the multiple storage accounts at a time via terraform code, we make use of the count 

        * Understand that count is list(string)
            so, while variabilising it in the variable.tf we have to give the names of the service-accounts which we want to create

            variable "storage_account_name" {
            type = list(string)
            default = ["nagashankar0848", "nagashankar0849", "nagashankar0850"]
            description = "the storage account name"
            }

            from the above variable.tf we can understand that three storage-accounts are going to be created with different names as displayed.

        * Understanding main.tf for the storage-account

            * here we need to specify the variable and the count as displayed below.

                resource "azurerm_storage_account" "example" {
                name                     = var.storage_account_name[count.index]
                count                    = length(var.storage_account_name)
                resource_group_name      = data.azurerm_resource_group.existing_rg.name
                location                 = data.azurerm_resource_group.existing_rg.location
                account_tier             = "Standard"
                account_replication_type = "GRS"

                tags = {
            environment = "staging"
                    }
                }

            * We have only single resource-group in our KodeKloud account, so we use it or declare it as data.azurerm_resource_group.existing_rg.name and data.azurerm_resource_group.existing_rg.location etc.....

            * Now run terraform plan, and see the magic

![alt text](Images/storage-account-count.png)

            * similarly we will have the azurerm_storage_account.example[1] and azurerm_storage_account.example[2]


        * Please look at the below image to know the difference between count and for_each

![alt text](Images/difference.png)



### Understanding Data Sources in Terraform

    * Terraform Data Source is like a "Read-Only Search" or "Look-Up" tool. It lets you fetch information about Azure resources that already exist (built manually or by another team) so you can use their details without recreating or modifying them.

    The Analogy: Building a House Extension

        * A Standard Resource Block (resource): This is you telling a contractor to build something brand new, like a new bedroom. If it's already there, trying to build it again will cause errors or unnecessary costs.

        * A Data Source Block (data): This is you asking a surveyor to measure the existing house. You aren't building a new house; you just need to know exactly where the main electrical panel is located so you can safely wire your new bedroom.

    Basic Syntax

    A data block starts with the data keyword, followed by the specific data source type and a local name:

        data "azurerm_resource_group" "existing_rg" {
        name = "production-resources"
        }    