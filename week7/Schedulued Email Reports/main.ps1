. (Join-Path $PSScriptRoot Configuration.ps1)
. (Join-Path $PSScriptRoot Events.ps1)
. (Join-Path $PSScriptRoot Scheduler.ps1)
. (Join-Path $PSScriptRoot Email.ps1)


$configuration = showConfiguration

$Failed  = atRiskUsers $configuration.Days

sendAlertEmail ($Failed  | Format-Table | Out-String)

chooseTimeToRun ($configuration.ExecutionTime)