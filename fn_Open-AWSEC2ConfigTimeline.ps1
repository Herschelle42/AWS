function Open-AWSEC2ConfigTimeline
{
<#
.SYNOPSIS
  For an instance id open a web browser to the Configuration Timeline.
.DESCRIPTION
  Opens a web browser to the supplied AWS Instance Id to the configuration Timeline for the Instance Id.
.NOTES
  Example: AWS Event History url
  https://<region>.console.aws.amazon.com/config/home?region=<region>#/resources/timeline?resourceId=<instanceId>&resourceType=AWS::EC2::Instance

  Requirements: 
    Logged into AWS into the correct Role for the browser where the url will be launched.
  
  Can use alias as well. For example using ff as an alias to launch FireFox
  New-Alias -Scope global -Name ff -Value "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"

.EXAMPLE
  Open-AWSEC2ConfigTimeline -InstanceId i-04e833d2102fa63d6
#>

Param (
    #The Instance Id(s) to open
    [Parameter(Mandatory,
        ValueFromPipeline,
        ValueFromPipelineByPropertyName,
        Position=0)]
    [Alias("CloudId")]
    [string[]]$InstanceId,
    #AWS Region to open. Default is ap-southeast-2
    [string]$Region = "ap-southeast-2",
    #The Browser to launch. Defaults to ch alias (for Chrome)
    [string]$BrowserPath="ch"
)

Begin
{

    #if a path has been given, create a new alias for use
    if (Test-Path $BrowserPath)
    {
        Write-Verbose "[INFO] Creating temporary alias"
        New-Alias -Scope local -Name Browser -Value $BrowserPath
    }

    #if an alias has been passed, remap
    if(Get-Alias $BrowserPath -ErrorAction SilentlyContinue)
    {
        Write-Verbose "[INFO] Duplicating alias for internal use"
        New-Alias -Scope local -Name Browser -Value (Get-Alias $BrowserPath).Definition
    }
  
}

Process
{
    foreach ($instance in $InstanceId)
    {
        Browser "https://$($Region).console.aws.amazon.com/config/home?region=$($Region)#/resources/timeline?resourceId=$($instance)&resourceType=AWS::EC2::Instance"

    }
}

End
{
    Write-Verbose "[INFO] End"
}

}
