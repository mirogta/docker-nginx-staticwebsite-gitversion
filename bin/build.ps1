. $(Join-Path $PSScriptRoot 'functions.ps1')

Write-Header "Building a Docker image:"

$versionedImageName = Get-ImageNameWithVersion
Write-Output "- $versionedImageName"
docker build -t $versionedImageName .
