$tenantId = "tenant-id"
$clientId = "client-id"
$clientSecret = "client-secret"
$registeredAppName = "display name of the app"
$username = "username"
$password = "password"
 
 
$accessToken = New-GraphAccessToken -TenantId $TenantId -ClientId $ClientId -ClientSecret $ClientSecret -Username $Username -Password $Password
$servicePrincipalId = Get-GraphServicePrincipal -AccessToken $accessToken -DisplayName $registeredAppName
$jobId = Get-GraphSynchronizationJobId -AccessToken $accessToken -ServicePrincipalId $servicePrincipalId
Start-GraphSynchronizationJob -AccessToken $accessToken -ServicePrincipalId $servicePrincipalId -JobId $jobId