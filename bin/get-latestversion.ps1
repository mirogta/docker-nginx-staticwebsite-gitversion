. $(Join-Path $PSScriptRoot 'functions.ps1')

Write-Header "Getting the latest version:"

$registryHost = Get-RegistryHost
$path = Get-RegistryPath
$imageName = Get-ImageName

$url = "http://$registryHost/v2/$path/$imageName/tags/list"
$response = Invoke-RestMethod $url
$tags = $response.tags

# NOTE: [-1] index gets the latest tag
# They should be already sorted in the response.
$latestVersion = $tags[-1]

Write-Output "- $latestVersion"
