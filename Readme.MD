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



### Understanding Terraform Meta Arguments

