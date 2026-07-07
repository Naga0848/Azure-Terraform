### This repo consists of Azure Terraform related info

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