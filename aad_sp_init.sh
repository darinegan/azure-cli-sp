#!/bin/bash
set -o errexit
set -o pipefail
set +o verbose

readonly DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null && pwd )"
readonly RBAC=$DIR/rbac.json

create_aad_sp() {
    local sub="$1"
    local json="$2"

    az account set --subscription="$sub"
    az ad sp create-for-rbac --role="Contributor" --scopes="/subscriptions/$sub" | tee $json
}

read_sp_json() {
    local json="$1"

    local readonly AZ_APP_ID=$(jq -r .appId $json)
    local readonly AZ_PASSWD=$(jq -r .password $json)
    local readonly AZ_TENANT=$(jq -r .tenant $json)

    az login --service-principal -u "$AZ_APP_ID" -p "$AZ_PASSWD" --tenant "$AZ_TENANT"
}

main() {
    case "$1" in
        read)
            read_sp_json "$RBAC"
            ;;
        create)
            create_aad_sp "$AZ_SUB_ID" "$RBAC"
            ;;
        *)
            echo $"Usage: $0 {read | create}"
            exit 1
    esac
}

main "$@"
