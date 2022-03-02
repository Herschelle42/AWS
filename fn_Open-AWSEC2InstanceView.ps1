function Open-AWSEC2InstanceView
{
<#
.SYNOPSIS
  For an EC2 resource name and or instance id open a web browser to the Instance View.
.DESCRIPTION
  Opens a web browser to the supplied AWS Instance Id and or resource name to the EC2 Instance View
.NOTES
  Example: AWS EC Instance View url
  https://<region>.console.aws.amazon.com/ec2/v2/home?region=<region>#Instances:search=<name>;sort=tag:Name
  https://<region>.console.aws.amazon.com/ec2/v2/home?region=<region>#Instances:search=<name>,<name>;sort=tag:Name


  Requirements: 
    Logged into AWS into the correct Role for the browser where the url will be launched.
  
  Can use alias as well. For example using ff as an alias to launch FireFox
  New-Alias -Scope global -Name ff -Value "C:\Program Files (x86)\Mozilla Firefox\firefox.exe"

.EXAMPLE
  Open-AWSEC2InstanceView -Name i-04e833d2102fa63d6,myServerName
#>
Param (
    #The Resource Name and or Instance Id(s) to open
    [Parameter(Mandatory,
        ValueFromPipeline,
        ValueFromPipelineByPropertyName,
        Position=0)]
    [Alias("CloudId","InstanceId","ResourceName")]
    [string[]]$Name,
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
    $searchName = $Name -join ","
    Browser "https://$($Region).console.aws.amazon.com/ec2/v2/home?region=$($Region)#Instances:search=$($searchName);sort=tag:Name"

}#end Process block

End
{
    
}

}

