# TOPdesk-Task-SA-Target-TOPdesk-ChangeUpdate
###########################################################
# Form mapping
$formObject = $form.updates
$changeId = $form.id
$changeDisplayName = $form.number

try {
    Write-Information "Executing TOPdesk action: [UpdateChange] for: [$($changeDisplayName)]"
    Write-Verbose "Creating authorization headers"
    # Create authorization headers with TOPdesk API key
    $pair = "${topdeskApiUsername}:${topdeskApiSecret}"
    $bytes = [System.Text.Encoding]::ASCII.GetBytes($pair)
    $base64 = [System.Convert]::ToBase64String($bytes)
    $key = "Basic $base64"
    $headers = @{
        "authorization" = $Key
        "Accept"        = "application/json"
    }

    Write-Verbose "Updating TOPdesk Change: [$($changeDisplayName)]"
    $splatUpdateChangeParams = @{
        Uri         = "$($topdeskBaseUrl)/tas/api/operatorChanges/$($changeId)"
        Method      = "PATCH"
        Body        = ([System.Text.Encoding]::UTF8.GetBytes(($formObject | ConvertTo-Json -Depth 10)))
        Verbose     = $false
        Headers     = $headers
        ContentType = "application/json-patch+json; charset=utf-8"
    }
    $response = Invoke-RestMethod @splatUpdateChangeParams

    $auditLog = @{
        Action            = "UpdateResource"
        System            = "TOPdesk"
        TargetIdentifier  = [String]$changeId
        TargetDisplayName = [String]$changeDisplayName
        Message           = "TOPdesk action: [UpdateChange] for: [$($changeDisplayName)] executed successfully"
        IsError           = $false
    }
    Write-Information -Tags "Audit" -MessageData $auditLog

    Write-Information "TOPdesk action: [UpdateChange] for: [$($changeDisplayName)] executed successfully"
}
catch {
    $ex = $_
    $auditLog = @{
        Action            = "UpdateResource"
        System            = "TOPdesk"
        TargetIdentifier  = [String]$changeId
        TargetDisplayName = [String]$changeDisplayName
        Message           = "Could not execute TOPdesk action: [UpdateChange] for: [$($changeDisplayName)], error: $($ex.Exception.Message)"
        IsError           = $true
    }
    if ($($ex.Exception.GetType().FullName -eq "Microsoft.PowerShell.Commands.HttpResponseException")) {
        $auditLog.Message = "Could not execute TOPdesk action: [UpdateChange] for: [$($changeDisplayName)]"
        Write-Error "Could not execute TOPdesk action: [UpdateChange] for: [$($changeDisplayName)], error: $($ex.ErrorDetails)"
    }
    Write-Information -Tags "Audit" -MessageData $auditLog
    Write-Error "Could not execute TOPdesk action: [UpdateChange] for: [$($changeDisplayName)], error: $($ex.Exception.Message)"
}
###########################################################