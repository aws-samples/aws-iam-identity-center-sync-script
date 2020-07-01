## AWS-SSO-SYNC
On Demand SCIM provisioning of Azure AD to AWS SSO with PowerShell

Fill in `each` of the items identified in the file from their corresponding values from the Azure Portal

```Powershell
$tenantId = "tenant-id"
$clientId = "client-id"
$clientSecret = "client-secret"
$registeredAppName = "display name of the app"
$username = "username"
$password = "password"
```

## Instructions

Once this has been completed - Please run the following lines of code to Trigger the Endpoint

```Powershell
$accessToken = New-GraphAccessToken `
                    -TenantId $TenantId `
                    -ClientId $ClientId `
                    -ClientSecret $ClientSecret `
                    -Username $Username `
                    -Password $Password
                    
$servicePrincipalId = Get-GraphServicePrincipal `
                            -AccessToken $accessToken `
                            -DisplayName $registeredAppName

$jobId = Get-GraphSynchronizationJobId `
                            -AccessToken $accessToken `
                            -ServicePrincipalId $servicePrincipalId

Start-GraphSynchronizationJob `
                            -AccessToken $accessToken `
                            -ServicePrincipalId $servicePrincipalId `
                            -JobId $jobId
```


## Security

See [CONTRIBUTING](CONTRIBUTING.md#security-issue-notifications) for more information.

## License

This library is licensed under the MIT-0 License. See the LICENSE file.

