targetScope = 'subscription'

@minLength(1)
@maxLength(64)
@description('Name of the environment that can be used as part of naming resource convention')
param environmentName string

@minLength(1)
@description('Primary location for all resources')
param location string

var tags = {
  'azd-env-name': environmentName
}


var resourceToken = toLower(uniqueString(subscription().id, environmentName, location))

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'rg-${environmentName}'
  location: location
  tags: tags
}

// EventHubs
module eventhubs './eventhubs.bicep' = {
  name: 'eventhubs'
  scope: rg
  params: {
    projectName: 'eh${resourceToken}'
    location: location
  }
}


// Function App
module functionApp './functionapp.bicep' = {
  name : 'functionApp'
  scope: rg
  params:{
    location:location
    eventHubsConnectionString: eventhubs.outputs.eventHubNamespaceConnectionString
  }
}
