## AWS-SSO-SYNC

## Overview
On Demand SCIM provisioning of Azure AD to AWS SSO with PowerShell

## Getting Started

### Prerequisites

Configure **AWS Single Sign-On** per the steps outlined in this [article](https://aws.amazon.com/blogs/aws/the-next-evolution-in-aws-single-sign-on/)

### App Registration

#### Create

- Navigate to Azure Active Directory
- Open the _App Registrations_ blade
- Select _New Registration_
  - Name: [_Example: AWS_]
  - All other options remain default
- Select _Register_
- Open the _Certificates & secrets_ blade
- Select _New client secret_
- Select _Add_
- Copy the Value shown within Client Secrets

#### Configure

- Navigate to Azure Active Directory
- Open the _App Registrations_ blade
- Select the app created in the previous task
- Open the _API Permissions_ blade
- Select _Add a permission_
- Choose _Microsoft Graph_
- Select _Delegated permissions_
- Scroll down to _Directory_ and expand
- Select _Directory.ReadWrite.All_
- Select _Add permissions_
- Select _Grant admin consent for [Tenant Name]_


### Service Account

- Navigate to Azure Active Directory
- Select _Users_ blade
- Choose _New user_
  - User name: [_Example: svc.aws_]
  - Name: [_Example: Service Account (AWS)_]
  - Password: _Let me create the password_
    - Provide secure value
- Select _Create_
- Navigate to new user
- Select _Assigned roles_
- Choose _Add assignments_
- Scroll down and select _Global administrator_



### Enterprise Application

- Navigate to Azure Active Directory
- Choose _Enterprise applications_ blade
- Select the app created in the previous task
- Choose _Users and groups_ blade
- Select _Add user_
- Select _Users_
- Choose service account created in previous task
- Select _Assign_

### Inputs

Gather the following properties for input into the PowerShell script

- Navigate to Azure Active Directory
- Choose _App Registrations_ blade
- Select the app created in the previous task
- Copy the following values:
  - Tenant Id
  - Application Name
  - Application Id
  - Client Secret
  - Username
  - Password


## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.

