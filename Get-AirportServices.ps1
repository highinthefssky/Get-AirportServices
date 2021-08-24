<#
.Synopsis
   Script to find AirportServices section in JSON file of mod
.DESCRIPTION
   Script to find AirportServices section in JSON file which could prevent MSFS 2020 groundservices to be unavailable
.EXAMPLE
   .\Get-AirportServices.ps1 -CommunityFolder C:\users\johan\appdata\local\Packages\Microsoft.FlightSimulator_8wekyb3d8bbwe\LocalCache\Packages\Community
#>
[CmdletBinding()]
Param(
[Parameter (Mandatory=$true)]
$CommunityFolder = ""
)

$jsonFiles = @()
$jsonFiles = Get-ChildItem $CommunityFolder -Filter layout.json -Recurse -Depth 1

foreach ($jsonFile in $jsonFiles)
{
    $content = ""
    $content = Get-Content $jsonFile.FullName -Raw|ConvertFrom-Json
    $airportServicesFound = $false

    foreach ($item in $($content.content.path))
    {
        if($item -like "*AirportServices*")
        {
                $AirportServicesFound = $true
        }
    }

    if ($airportServicesFound)
    {
        Write-Host "AirportServices section found in $($jsonFile.FullName)"
    }
}