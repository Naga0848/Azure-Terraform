### This is repo is to understand the Azure Entra-ID

https://registry.terraform.io/providers/hashicorp/azuread/latest/docs/data-sources/domains

### understand how Entra-ID works

    * Azure is a full public cloud computing platform, while Azure Active Directory (now renamed Microsoft Entra ID) is a specific cloud service for managing user identities and log-in access. Azure provides virtual computers, databases, and networks, whereas Azure AD handles passwords, multi-factor security, and sign-ins for apps like Microsoft 365

    * We initialize this repo using the azuread rather than azurerm.

    * Using the main.tf in this folder we try to list the domains existing in our current subscription plan.

![alt text](Images/domain.png)