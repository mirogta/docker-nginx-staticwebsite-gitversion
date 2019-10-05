. $(Join-Path $PSScriptRoot 'functions.ps1')

Write-Header "Publishing a Docker image:"

$registryHost = Get-RegistryHost
$path = Get-RegistryPath
$versionedImageName = Get-ImageNameWithVersion
$tag = "$registryHost/$path/$versionedImageName"
Write-Output "- $tag"

docker tag $versionedImageName $tag
docker push $tag