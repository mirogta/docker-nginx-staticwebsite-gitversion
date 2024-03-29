function Write-Header
{
    <#
    .Description
    Write-Header Writes an output using a yellow color
    to visually separate it from the rest of the output
    #>

    # save the current color
    $currentColour = $host.UI.RawUI.ForegroundColor

    # set the new color
    $host.UI.RawUI.ForegroundColor = 'Yellow'

    # output
    if ($args) {
        Write-Output $args
    }
    else {
        $input | Write-Output
    }

    # restore the original color
    $host.UI.RawUI.ForegroundColor = $currentColour
}

function Get-ImageName
{
    <#
    .Description
    Get-ImageName Returns a string with a Docker image name.
    For the sake of simplicity, the image name is determined by the directory
    where the code is checked out, which is typically the name of the repository.
    #>

    (Get-Item $pwd).Name
}

function Get-ImageVersion
{
    <#
    .Description
    Get-ImageVersion Returns a string with a Docker image version using GitVersion.
    This relies on GitVersion.yml configuration and commits,
    so if you want to increase the version make sure you commit your code first.
    #>

    gitversion /showvariable SemVer
}

function Get-ImageNameWithVersion
{
    <#
    .Description
    Get-ImageNameWithVersion Returns a string with a Docker image name and version

    .LINK
    Get-ImageName

    .LINK
    Get-ImageVersion
    #>

    $imageName = Get-ImageName
    $version = Get-ImageVersion

    "${imageName}:$version"
}

function Get-RegistryHost
{
    <#
    .Description
    Get-RegistryHost Returns a Docker registry host:port

    Please note that for the sake of simplicity, this is hard-coded here.
    It could be parametrised, set from CI/CD or elsewhere.
    #>

    'localhost:5000'
}

function Get-RegistryPath
{
    <#
    .Description
    Get-RegistryPath Returns a Docker registry path

    Please note that for the sake of simplicity, all the variables are hard-coded here.
    They could be parametrised, set from CI/CD or elsewhere.
    #>

    $vendor = 'vocalink'
    $project = 'exercise'

    "$vendor/$project"
}