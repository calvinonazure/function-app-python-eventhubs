# Steps to customize azd template

## 01 - Test Bicep Template

1. Create a Resource Group 
2. Execute az command to deploy bicep template

How to find bicep templates : Search "azure product" + "bicep"
- https://learn.microsoft.com/en-us/azure/templates/microsoft.eventhub/namespaces/eventhubs?pivots=deployment-language-bicep
- https://github.com/Azure/azure-quickstart-templates/tree/master/quickstarts/microsoft.web/function-http-trigger

```powershell
$rg = "bicep-test1"
az deployment group create --resource-group $rg --template-file ./eventhubs.bicep

# Note, Some Variables could be dummy value, or we need update it manually, e.g. eventHubsConnectionString
az deployment group create --resource-group $rg --template-file ./functionapp.bicep
```

## 02 - Test Source Code
You could test the application code from your local firstly. 
The azd supported application "appservice", "containerapp" , "function", "staticwebapp" and "aks"
please refer check host configuration from https://github.com/Azure/azure-dev/blob/main/schemas/v1.0/azure.yaml.json

## 03 - use azd initiliaze folder

check azure.yaml and infra folder

```powershell
azd init
```

## 04 - Put all three files together and test
- Understand azure.yaml
- Understand infra
- Understand src
- Common bicep templates
