Param (
    [Parameter(ValueFromPipeline)]
    [string] $SubscriptionID,
    [Parameter(Mandatory)]
    [string] $Path
)

$env:ARM_SUBSCRIPTION_ID = $SubscriptionID

$Json = Get-Content $Path

$env:ARM_CLIENT_ID = $($Json | jq -r .appId)
$env:ARM_CLIENT_SECRET = $($Json | jq -r .password)
$env:ARM_TENANT_ID = $($Json | jq -r .tenant)
