### This is repo is to understand the Azure Entra-ID

https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/domains

### understand how Entra-ID works

    * Azure is a full public cloud computing platform, while Azure Active Directory (now renamed Microsoft Entra ID) is a specific cloud service for managing user identities and log-in access. Azure provides virtual computers, databases, and networks, whereas Azure AD handles passwords, multi-factor security, and sign-ins for apps like Microsoft 365

    * We initialize this repo using the azuread rather than azurerm.

    * Using the main.tf in this folder we try to list the domains existing in our current subscription plan.

![alt text](Images/domain.png)

    * From the above image we can undertand that a domain is present in our current subscription plan.

    * Even if we mention 0 in the place of * in main.tf it results only the same domain in the form of simple variable where as if has returned a list when we used * 

![alt text](Images/outputs.png)

    * From the above image we can understand that the usernames are getting printed as we have decoded our users.csv file and the domain is prented two times because we have used output two times in main.tf

    * The below image is for creating the active user directory.
    
    * A user principal in Microsoft Entra ID (formerly Azure AD) is an object that represents an individual user and defines their identity, sign-in credentials, and permissions. It is identified by a unique User Principal Name (UPN), structured like an email address.

![alt text](Images/krishna.png)

     # azuread_user.users["KrishnaPrasad"] will be created
  + resource "azuread_user" "users" {
      + about_me                       = (known after apply)
      + account_enabled                = true
      + business_phones                = (known after apply)
      + creation_type                  = (known after apply)
      + department                     = "Education"
      + disable_password_expiration    = false
      + disable_strong_password        = false
      + display_name                   = "KrishnaPrasad Dakhi"
      + external_user_state            = (known after apply)
      + force_password_change          = true
      + id                             = (known after apply)
      + im_addresses                   = (known after apply)
      + job_title                      = "Engineer"
      + mail                           = (known after apply)
      + mail_nickname                  = (known after apply)
      + object_id                      = (known after apply)
      + onpremises_distinguished_name  = (known after apply)
      + onpremises_domain_name         = (known after apply)
      + onpremises_immutable_id        = (known after apply)
      + onpremises_sam_account_name    = (known after apply)
      + onpremises_security_identifier = (known after apply)
      + onpremises_sync_enabled        = (known after apply)
      + onpremises_user_principal_name = (known after apply)
      + password                       = (sensitive value)
      + proxy_addresses                = (known after apply)
      + show_in_address_list           = true
      + user_principal_name            = "Kdakhi@azurekmlprodkodekloud.onmicrosoft.com"
      + user_type                      = (known after apply)
    }


![alt text](Images/Nagashankar.png)


    # azuread_user.users["Nagashankar"] will be created
  + resource "azuread_user" "users" {
      + about_me                       = (known after apply)
      + account_enabled                = true
      + business_phones                = (known after apply)
      + creation_type                  = (known after apply)
      + department                     = "Education"
      + disable_password_expiration    = false
      + disable_strong_password        = false
      + display_name                   = "Nagashankar Janapati"
      + external_user_state            = (known after apply)
      + force_password_change          = true
      + id                             = (known after apply)
      + im_addresses                   = (known after apply)
      + job_title                      = "Manager"
      + mail                           = (known after apply)
      + mail_nickname                  = (known after apply)
      + object_id                      = (known after apply)
      + onpremises_distinguished_name  = (known after apply)
      + onpremises_domain_name         = (known after apply)
      + onpremises_immutable_id        = (known after apply)
      + onpremises_sam_account_name    = (known after apply)
      + onpremises_security_identifier = (known after apply)
      + onpremises_sync_enabled        = (known after apply)
      + onpremises_user_principal_name = (known after apply)
      + password                       = (sensitive value)
      + proxy_addresses                = (known after apply)
      + show_in_address_list           = true
      + user_principal_name            = "Njanapati@azurekmlprodkodekloud.onmicrosoft.com"
      + user_type                      = (known after apply)
    }


![alt text](Images/Ramkumar.png)

    *   And finally the usernames are also printed.

![alt text](Images/users.png)

