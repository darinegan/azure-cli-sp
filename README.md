# Azure Client

The Microsoft Azure CLI Docker Image; wrapped with some added support for using a Service Principal.

## Requirements

- [jq](https://stedolan.github.io/jq/download/)

## Usage

Invoke the following to start the [Azure CLI][dockerhub-msft-azurecli].

```powershell
.\setup.ps1
```

Login to the Azure CLI following any on-screen instructions to complete login.

```bash
az login
```

Once login is successful, a list of subscriptions associated with the account is displayed. Alternatively, you can execute the following Azure CLI command to verify.

```bash
az account list
```

## Setting the Subscription ID

The subscription ID can be specified when the setup script is invoked.

```powershell
.\setup.ps1 [[-SubscriptionID] <String>]
```

Otherwise, once logged in to the Azure CLI, select a subscription from the list associated with your account and set the subscription ID as follows.

```bash
export AZ_SUB_ID=$(az account list | jq -r .[0].id)
```

## Creating a Service Principal

In order to create a Service Principal, the `Path` parameter must be specified when invoking the setup script. The Subscription ID can be specified as before.

The `Path` parameter references a text file which is written with the configuration values when the Service Principal is created.

```powershell
.\setup.ps1 [[-SubscriptionID] <String>] [-Path <String>]
```

Once logged in, invoke the helper script as below to create a Service Principal with Contributor role associated with the specified subscription ID.

```bash
/root/aad_sp_init.sh create
```

When complete, the Service Principal configuration values are available within the container under the following path.

```bash
cat /root/rbac.json
```

## [Optional] Login as Service Principal

If there is an existing Service Principal created previously, it is possible to login using this.

Invoke the setup script passing the `Path` parameter to the text file which contains the Service Principal configuration values when created.

```powershell
.\setup.ps1 -Path <String>
```

Using the helper script, invoke this as follows to read the configuration values and login to the Azure CLI.

```bash
/root/aad_sp_init.sh read
```

Fin.

[dockerhub-msft-azurecli]: https://hub.docker.com/r/microsoft/azure-cli/ "Docker Hub Microsoft Azure CLI"
