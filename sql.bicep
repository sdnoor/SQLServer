param location string
param serverName string
param databaseName string
param adminLogin string
@secure()
param adminPassword string

@allowed([
'dev'
'prod'
])
param environmentType string



resource sqlServer 'Microsoft.Sql/servers@2021-08-01-preview' ={
  name: '${serverName}-${environmentType}'
  location: location
  properties: {
    administratorLogin: adminLogin
    administratorLoginPassword: adminPassword
  }
}

resource sqlServerDatabase 'Microsoft.Sql/servers/databases@2021-08-01-preview' = {
  parent: sqlServer
  name: '${databaseName}-${environmentType}'
  location: location
  properties: {
    collation: 'collation'
    edition: 'Basic'
    maxSizeBytes: 'maxSizeBytes'
    requestedServiceObjectiveName: 'Basic'
    zoneRedundant: true
  }
  sku: {
    name: 'N41'
    tier: 'Basic'
    capacity: 10
  }
}
