function Open-AWSEventHistory
{
<#
.SYNOPSIS
  For an instance id open a web browser to the Event History.
.DESCRIPTION
  Opens a web browser to the supplied AWS Instance Id to the Event History for the Instance Id.
.NOTES
  Example: AWS Event History url
  https://<region>.console.aws.amazon.com/cloudtrail/home?region=<region>#/events?ResourceName=<instanceId>&StartTime=2020-02-09T17:00:00.000Z&EndTime=2020-02-09T23:00:00.000Z

  Requirements: 
    Logged into AWS into the correct Role for the browser where the url will be launched.

.EXAMPLE
  Open-AWSEventHistory -InstanceId i-04e833d2102fa63d6 -After 2020-03-04
#>
Param (
    #The Instance Id(s) to open
    [Parameter(Mandatory,ValueFromPipeline,Position=0)]
    [string[]]$InstanceId,
    #AWS Region to open. Default is ap-southeast-2
    [string]$Region = "ap-southeast-2",
    #Logs after this time. Default is 24 hours ago.
    [datetime]$After = $((Get-Date).AddDays(-1)),
    #Logs before this time. Default is now.
    [datetime]$Before = $(Get-Date)
)

Begin
{
    #Convert time to Zulu
    $startTime = ($After | Get-Date).ToUniversalTime() | Get-Date -UFormat "%Y-%m-%dT%H:%M:%S.000Z"
    Write-Verbose "[INFO] $($StartTime)"
    $endTime = ($Before | Get-Date).ToUniversalTime() | Get-Date -UFormat "%Y-%m-%dT%H:%M:%S.000Z"
    Write-Verbose "[INFO] $($endTime)"
  
}#end Begin

Process
{
    foreach ($instance in $InstanceId)
    {
    #launch in firefox
    #New-Alias -Scope global -Name ff -Value "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"
    ff "https://$($Region).console.aws.amazon.com/cloudtrail/home?region=$($Region)#/events?ResourceName=$($instance)&StartTime=$($startTime)&EndTime=$($endTime)"

    }#end foreach
}#end Process block

End
{
    
}#end end

}#end function
