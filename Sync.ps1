#Requires -Version 7.0
#region Get
function Get-GraphSynchronizationJobId() {

    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [securestring]$AccessToken,
 
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$ServicePrincipalId
    )
 
    begin {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " begin")
        $params = @{
            Method  = "GET"
            Uri     = ("https://graph.microsoft.com/beta/servicePrincipals/" + $servicePrincipalId + "/synchronization/jobs")
            Headers = @{
                "Authorization" = ("Bearer " + (ConvertFrom-SecureString -SecureString $accessToken -AsPlainText))
                "Accept"        = "application/json"
            }
            Body    = @{ }
        }
    }
 
    process {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " process")
        try {
            $response = Invoke-RestMethod @params
            $response = $response.value[0].id
        }
        catch {
            Write-Error -ErrorRecord $_ -ErrorAction Stop
        }
    }
 
    end {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " end")
        return $response
    }
 
}
function Get-GraphServicePrincipal() {

    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [securestring]$AccessToken,
 
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$DisplayName
    )
 
    begin {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " begin")
        $params = @{
            Method  = "GET"
            Headers = @{
                "Authorization" = ("Bearer " + (ConvertFrom-SecureString -SecureString $accessToken -AsPlainText))
                "Accept"        = "application/json"
            }
        }
    }
 
    process {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " process")
        try {
            $response = Invoke-RestMethod @params -Uri "https://graph.microsoft.com/beta/servicePrincipals"
            $response.value | ForEach-Object {
                if ($_.displayName -like $displayName) {
                    $objectId = $_.id
                }
            }
            if ($response.'@odata.nextLink') {
                Write-Verbose -Message "NextLink Section"
                $nextLink = $response.'@odata.nextLink'
                while ($nextLink -ne $null) {
                    $output = Invoke-RestMethod @params -Uri $nextLink
                    $output.value | ForEach-Object {
                        if ($_.displayName -like $displayName) {
                            $objectId = $_.id
                        }
                    }
                    $nextLink = $output.'@odata.nextLink'
 
                }
            }
        }
        catch {
            Write-Error -ErrorRecord $_ -ErrorAction Stop
        }
    }
 
    end {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " end")
        return $objectId
    }
 
}
#endregion

#region New
function New-GraphAccessToken() {

    [CmdletBinding()]
    [OutputType([securestring])]
    param (
        [Parameter(Mandatory = $true)]
        [string]$TenantId,
 
        [Parameter(Mandatory = $true)]
        [string]$ApplicationId,
 
        [Parameter(Mandatory = $true)]
        [securestring]$ClientSecret,
 
        [Parameter(Mandatory = $true)]
        [string]$Username,
 
        [Parameter(Mandatory = $true)]
        [securestring]$Password
    )
 
    begin {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " begin")
        $params = @{
            Method  = "POST"
            Uri     = ("https://login.microsoftonline.com/" + $tenantId + "/oauth2/token")
            Headers = @{
                "Content-Type" = "application/x-www-form-urlencoded"
                "Accept"       = "application/json"
            }
            Body    = @{
                "resource"      = "https://graph.microsoft.com"
                "grant_type"    = "password"
                "client_id"     = "$applicationId"
                "client_secret" = "$(ConvertFrom-SecureString -SecureString $clientSecret -AsPlainText)"
                "username"      = "$username"
                "password"      = "$(ConvertFrom-SecureString -SecureString $password -AsPlainText)"
                "scope"         = "openid"
            }
        }
    }
 
    process {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " process")
        try {
            $response = Invoke-RestMethod @params
            $accessToken = ConvertTo-SecureString -String "$($response.access_token)" -AsPlainText -Force
        }
        catch {
            Write-Error -ErrorRecord $_ -ErrorAction Stop
        }
    }
 
    end {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " end")
        return $accessToken
    }
 
}
#endregion

#region Start
function Start-GraphSynchronizationJob() {

    [CmdletBinding()]
    [OutputType([string])]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [securestring]$AccessToken,
 
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$ServicePrincipalId,
 
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$JobId
    )
 
    begin {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " begin")
        $params = @{
            Method  = "POST"
            Uri     = ("https://graph.microsoft.com/beta/servicePrincipals/" + $servicePrincipalId + "/synchronization/jobs/" + $JobId + "/start")
            Headers = @{
                "Authorization" = ("Bearer " + (ConvertFrom-SecureString -SecureString $accessToken -AsPlainText))
            }
        }
    }
 
    process {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " process")
        try {
            $response = Invoke-RestMethod @params
        }
        catch {
            Write-Error -ErrorRecord $_ -ErrorAction Stop
        }
    }
 
    end {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " end")
        return $response
    }
 
}
#endregion

#region Initialization
function Initialization {

    [CmdletBinding()]
    param ()

    begin {
        Clear-Host
        Write-Host "AWS Single Sign-On Integration - Sync`n" -ForegroundColor Yellow

        $tenantId = Read-Host -Prompt "Tenant Id"
        if ([string]::IsNullOrEmpty($tenantId)) { Write-Error -Message "Tenant Id cannot be blank." -ErrorAction Stop }

        $displayName = Read-Host -Prompt "App Name"
        if ([string]::IsNullOrEmpty($displayName)) { Write-Error -Message "Display Nane cannot be blank." -ErrorAction Stop }

        $applicationId = Read-Host -Prompt "App Id"
        if ([string]::IsNullOrEmpty($applicationId)) { Write-Error -Message "Application Id cannot be blank."  -ErrorAction Stop }

        $clientSecret = Read-Host -Prompt "Client Secret" -AsSecureString
        if ([string]::IsNullOrEmpty($clientSecret)) { Write-Error -Message "Client Secret cannot be blank."  -ErrorAction Stop }

        $username = Read-Host -Prompt "Username"
        if ([string]::IsNullOrEmpty($username)) { Write-Error -Message "Username cannot be blank."  -ErrorAction Stop }

        $password = Read-Host -Prompt "Password" -AsSecureString
        if ([string]::IsNullOrEmpty($password)) { Write-Error -Message "Password cannot be blank."  -ErrorAction Stop }
        
        Clear-Host
        Write-Host "AWS Single Sign-On Integration - Sync Starting" -ForegroundColor Yellow
    }

    process {
        $accessToken = New-GraphAccessToken -TenantId $tenantId -ApplicationId $applicationId -ClientSecret $clientSecret -Username $username -Password $password
        $servicePrincipalId = Get-GraphServicePrincipal -AccessToken $accessToken -DisplayName $displayName
        $jobId = Get-GraphSynchronizationJobId -AccessToken $accessToken -ServicePrincipalId $servicePrincipalId
        Start-GraphSynchronizationJob -AccessToken $accessToken -ServicePrincipalId $servicePrincipalId -JobId $jobId
    }

    end {
        Write-Host "AWS Single Sign-On Integration - Sync Completed" -ForegroundColor Green
    }

}
#endregion

Initialization