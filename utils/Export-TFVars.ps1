Param (
    [Parameter(Mandatory,ValueFromPipeline)]
    [string] $Path
)

$Json = Get-Content $Path

$env:ARM_CLIENT_ID = $($Json | jq -r .appId)
$env:ARM_CLIENT_SECRET = $($Json | jq -r .password)
$env:ARM_TENANT_ID = $($Json | jq -r .tenant)
