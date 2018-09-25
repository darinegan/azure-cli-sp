Param (
    [Parameter(Mandatory)]
    [string] $Path
)

$ParentPath = Split-Path -Path $Path -Parent
$LeafPath = Split-Path -Path $Path -Leaf

Push-Location $ParentPath
    $env:ARM_CLIENT_ID = $(jq -r .appId $LeafPath)
    $env:ARM_CLIENT_SECRET = $(jq -r .password $LeafPath)
    $env:ARM_TENANT_ID = $(jq -r .tenant $LeafPath)
Pop-Location
