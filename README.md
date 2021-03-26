## AWS-SSO-SYNC

## Overview
On Demand SCIM provisioning of Azure AD to AWS SSO with PowerShell
 - This repo is based on the steps outlined in this [article](https://aws.amazon.com/blogs/security/on-demand-scim-provisioning-of-azure-ad-to-aws-sso-with-powershell/) updated Jan 2021.

## Getting Started

### Prerequisites

Configure **AWS Single Sign-On** with the steps outlined in this [article](https://aws.amazon.com/blogs/aws/the-next-evolution-in-aws-single-sign-on/)

### App Registration

#### Create

- Navigate to Azure Active Directory
- Open the _App Registrations_ blade
- Choose _New Registration_
  - Name: [_Example: AWS_]
  - All other options remain default
- Choose _Register_
- Open the _Certificates & secrets_ blade
- Choose _New client secret_
- Choose _Add_
- Copy the Value shown within Client Secrets

#### Configure

- Navigate to Azure Active Directory
- Open the _App Registrations_ blade
- Choose the app created in the previous task
- Open the _API Permissions_ blade
- Choose _Add a permission_
- Choose _Microsoft Graph_
- Choose _Delegated permissions_
- Scroll down to _Directory_ and expand
- Choose _Directory.ReadWrite.All_
- Choose _Add permissions_
- Choose _Grant admin consent for [Tenant Name]_


### Service Account

- Navigate to Azure Active Directory
- Choose _Users_ blade
- Choose _New user_
  - User name: [_Example: svc.aws_]
  - Name: [_Example: Service Account (AWS)_]
  - Password: _Let me create the password_
    - Provide secure value
- Choose _Create_
- Navigate to new user
- Choose _Assigned roles_
- Choose _Add assignments_
- Scroll down and Choose _Hybrid identity administrator_
- Under _Settings_ choose _Active_
- Choose _Assign_

### Enterprise Application

- Navigate to Azure Active Directory
- Choose _Enterprise applications_ blade
- Choose the app created in the previous task
- Choose _Users and groups_ blade
- Choose _Add user_
- Choose _Users_
- Choose service account created in previous task
- Choose _Assign_

### Inputs

Gather the following properties for input into the PowerShell script

* Navigate to Azure Active Directory
* Choose _App Registrations_ blade
* Choose the app created in the previous task
* Copy the following values:
  - Tenant Id
  - Application Name
  - Application Id
  - Client Secret
  - Username
  - Password

> Note: When copying and pasting in Windows, choose the PowerShell icon, then Edit > Paste.


## License

This library is licensed under the MIT-0 License. See the LICENSE file.

