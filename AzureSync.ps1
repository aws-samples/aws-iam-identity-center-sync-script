
#region New
function New-GraphAccessToken() {
 
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$TenantId,
 
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$ClientId,
 
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$ClientSecret,
 
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$Username,
 
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$Password
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
                "client_id"     = "$clientId"
                "client_secret" = "$clientSecret"
                "username"      = "$username"
                "password"      = "$password"
                "scope"         = "openid"
            }
        }
    }
 
    process {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " process")
        try {
            $response = Invoke-RestMethod @params
            $accessToken = $response.access_token
        }
        catch {
            Write-Error -Message $_.Exception.Message -ErrorAction Stop
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
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$AccessToken,
 
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
                "Authorization" = ("Bearer " + $accessToken)
                "Accept"        = "application/json"
            }
            Body    = @{ }
        }
    }
 
    process {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " process")
        try {
            $response = Invoke-RestMethod @params
        }
        catch {
            Write-Error -Message $_.Exception.Message -ErrorAction Stop
        }
    }
 
    end {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " end")
        return $response
    }
 
}
#endregion
 
#region Stop
function Stop-GraphSynchronizationJob() {
 
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$AccessToken,
 
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
            Uri     = ("https://graph.microsoft.com/beta/servicePrincipals/" + $servicePrincipalId + "/synchronization/jobs/" + $JobId + "/stop")
            Headers = @{
                "Authorization" = ("Bearer " + $accessToken)
                "Accept"        = "application/json"
            }
            Body    = @{ }
        }
    }
 
    process {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " process")
        try {
            $response = Invoke-RestMethod @params
        }
        catch {
            Write-Error -Message $_.Exception.Message -ErrorAction Stop
        }
    }
 
    end {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " end")
        return $response
    }
 
}
#endregion
 
#region Get
function Get-GraphSynchronizationJob() {
 
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$AccessToken,
 
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
            Uri     = ("https://graph.microsoft.com/beta/servicePrincipals/" + $servicePrincipalId + "/synchronization/jobs/" + $JobId)
            Headers = @{
                "Authorization" = ("Bearer " + $accessToken)
                "Accept"        = "application/json"
            }
            Body    = @{ }
        }
    }
 
    process {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " process")
        try {
            $response = Invoke-RestMethod @params
        }
        catch {
            Write-Error -Message $_.Exception.Message -ErrorAction Stop
        }
    }
 
    end {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " end")
        return $response
    }
 
}
function Get-GraphSynchronizationJobId() {
 
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$AccessToken,
 
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$ServicePrincipalId
    )
 
    begin {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " begin")
        $params = @{
            Method  = "GET"
            Uri     = ("https://graph.microsoft.com/beta/servicePrincipals/" + $servicePrincipalId + "/synchronization/jobs/")
            Headers = @{
                "Authorization" = ("Bearer " + $accessToken)
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
            Write-Error -Message $_.Exception.Message -ErrorAction Stop
        }
    }
 
    end {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " end")
        return $response
    }
 
}
function Get-GraphSynchronizationJobs() {
 
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$AccessToken,
 
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$ServicePrincipalId
    )
 
    begin {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " begin")
        $params = @{
            Method  = "POST"
            Uri     = ("https://graph.microsoft.com/beta/servicePrincipals/" + $servicePrincipalId + "/synchronization/jobs")
            Headers = @{
                "Authorization" = ("Bearer " + $accessToken)
                "Accept"        = "application/json"
            }
            Body    = @{ }
        }
    }
 
    process {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " process")
        try {
            $response = Invoke-RestMethod @params
        }
        catch {
            Write-Error -Message $_.Exception.Message -ErrorAction Stop
        }
    }
 
    end {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " end")
        return $response
    }
 
}
function Get-GraphServicePrincipal() {
 
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$AccessToken,
 
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$DisplayName
    )
 
    begin {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " begin")
        $params = @{
            Method  = "GET"
            Headers = @{
                "Authorization" = ("Bearer " + $accessToken)
                "Accept"        = "application/json"
            }
            Body    = @{ }
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
            Write-Error -Message $_.Exception.Message -ErrorAction Stop
        }
    }
 
    end {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " end")
        return $objectId
    }
 
}
function Get-GraphServicePrincipals() {
 
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [ValidateNotNull()]
        [string]$AccessToken
    )
 
    begin {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " begin")
        $params = @{
            Method  = "GET"
            Uri     = ("https://graph.microsoft.com/beta/servicePrincipals")
            Headers = @{
                "Authorization" = ("Bearer " + $accessToken)
                "Accept"        = "application/json"
            }
            Body    = @{ }
        }
    }
 
    process {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " process")
        try {
            $response = Invoke-RestMethod @params
        }
        catch {
            Write-Error -Message $_.Exception.Message -ErrorAction Stop
        }
    }
 
    end {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " end")
        return $response
    }
 
}
#endregion
 
#region Invoke
function Invoke-GraphSynchronization() {
 
    [CmdletBinding()]
    param ()
 
    begin {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " begin")
    }
 
    process {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " process")
    }
 
    end {
        Write-Verbose -Message ("Initiating function " + $MyInvocation.MyCommand + " end")
    }
 
}
#end