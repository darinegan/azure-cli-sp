Param (
    [Parameter(Mandatory)]
    [string] $Path
)

$env:ARM_CLIENT_ID = $(jq -r .appId $Path)
$env:ARM_CLIENT_SECRET = $(jq -r .password $Path)
$env:ARM_TENANT_ID = $(jq -r .tenant $Path)
