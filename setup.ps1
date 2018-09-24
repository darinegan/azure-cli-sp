Param (
    [string] $SubscriptionID,
    [string] $Path
)

$ScriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
$AADSP = 'aad_sp_init.sh'

docker run -it `
    -e AZ_SUB_ID=${SubscriptionID} `
    -v ${ScriptPath}/${AADSP}:/root/${AADSP} `
    -v ${Path}:/root/rbac.json `
    microsoft/azure-cli
