#################################
## Deploy BackUpState WorkBook ##
#################################
resource "azurerm_application_insights_workbook" "backupstate" {
  name                = "83a3945a-196c-4c48-b7ec-003d7639d09e"
  location            = var.location
  resource_group_name = var.resource_group_name
  display_name        = "BackUpState"
  data_json = jsonencode({
  "version": "Notebook/1.0",
  "items": [
    {
      "type": 9,
      "content": {
        "version": "KqlParameterItem/1.0",
        "parameters": [
          {
            "id": "",
            "version": "KqlParameterItem/1.0",
            "name": "Help",
            "label": "Afficher Aide",
            "type": 10,
            "isRequired": true,
            "typeSettings": {
              "additionalResourceOptions": []
            },
            "jsonData": "[\r\n { \"value\": \"Yes\", \"label\": \"Yes\"},\r\n { \"value\": \"No\", \"label\": \"No\", \"selected\":true },\r\n { \"value\": \"Change Log\", \"label\": \"Change Log\"}\r\n]",
            "value": "Yes"
          }
        ],
        "style": "pills",
        "queryType": 0,
        "resourceType": "microsoft.operationalinsights/workspaces"
      },
      "name": "parameters - 8"
    },
    {
      "type": 1,
      "content": {
        "json": "### Change Log\r\nCe rapport restitue les differents états de backup des Storage Account & Bases de données\r\n\r\n|Version|Description|\r\n|---|---|\r\n|v1| Initial Release - Octobre 2022 - Hardis Group\r\n|v2| Release - Avril 2023 - Hardis Group\r\n\r\n\r\n\r\n"
      },
      "conditionalVisibility": {
        "parameterName": "Help",
        "comparison": "isEqualTo",
        "value": "Change Log"
      },
      "name": "text - Change Log"
    },
    {
      "type": 1,
      "content": {
        "json": "## Important - Missing Resources\r\n\t- Ce workbook s'appuie sur Azure Resource Graph et Application Insights. Il est donc impératif d'avoir accès (lecture seule) à l'ensemble des ressources et insights de monitoring\r\n\r\n"
      },
      "conditionalVisibility": {
        "parameterName": "Help",
        "comparison": "isEqualTo",
        "value": "none"
      },
      "name": "text - Help file"
    },
    {
      "type": 1,
      "content": {
        "json": "Sélectionnez la (ou les) souscription(s) dans la liste deroulante",
        "style": "info"
      },
      "name": "texte - Conseil Overview"
    },
    {
      "type": 9,
      "content": {
        "version": "KqlParameterItem/1.0",
        "parameters": [
          {
            "id": "",
            "version": "KqlParameterItem/1.0",
            "name": "Subscriptions",
            "type": 6,
            "isRequired": true,
            "multiSelect": true,
            "quote": "'",
            "delimiter": ",",
            "value": [
              "/subscriptions/f1fc57e7-dad4-46d5-962b-1459afabdc3c",
              "/subscriptions/636c7ec6-4895-425e-823a-29f0f071caac",
              "/subscriptions/4643c0c8-d4fc-4b68-af0e-7f31c9aedf07",
              "/subscriptions/b0ca49a3-a64e-4e1a-9ca1-77e9cfbfad3b",
              "/subscriptions/370db10d-fcad-4326-80c6-792b6ad15342",
              "/subscriptions/73cd5fbc-e38c-4c81-9d28-440f028060da",
              "/subscriptions/89d08743-712c-4f3c-9e3e-7b1800d7bcb8",
              "/subscriptions/eaa1e892-35b5-4535-96f6-2ec07f6b21f2",
              "/subscriptions/dbb243e5-3d78-4a35-b865-6bfdc013f4cc",
              "/subscriptions/b4be0b30-b281-4bee-9643-e0814e8dc01d",
              "/subscriptions/d1d64257-50ae-4f67-93f6-2d3a404e3563",
              "/subscriptions/2b5f23a9-08c4-44f1-8ec8-e3fb44256de9",
              "/subscriptions/9774e611-b687-4b9a-9d5c-c72ca2a93fd3",
              "/subscriptions/7c52150a-7518-429f-bf9b-637d2e0cec41",
              "/subscriptions/c504f0ee-6e91-4e99-a4ef-780206c8899d",
              "/subscriptions/55f14124-5284-4924-9f3b-20a1b58ea068",
              "/subscriptions/ac3c100d-f92d-4ccf-a806-0d3fe66281fd",
              "/subscriptions/ba6260e7-f027-42f0-bb47-38c9a35d9317",
              "/subscriptions/895be2a1-7f48-4297-9000-957064963715",
              "/subscriptions/259b48a1-7ff8-4a23-9c8b-9c0196d163db",
              "/subscriptions/49036db4-0d80-450e-9f7c-aa4ea167a023",
              "/subscriptions/7aff75fa-6f4e-4baa-8f82-478e35e795f5",
              "/subscriptions/15ea59c4-1298-4f3c-9ffd-58356a028dd7"
            ],
            "typeSettings": {
              "additionalResourceOptions": [
                "value::1",
                "value::all"
              ],
              "includeAll": true
            }
          }
        ],
        "style": "pills",
        "queryType": 0,
        "resourceType": "microsoft.operationalinsights/workspaces"
      },
      "name": "parameters - 8"
    },
    {
      "type": 9,
      "content": {
        "version": "KqlParameterItem/1.0",
        "crossComponentResources": [
          "{Subscriptions}"
        ],
        "parameters": [
          {
            "id": "",
            "version": "KqlParameterItem/1.0",
            "name": "SubscriptionId",
            "type": 1,
            "isRequired": true,
            "query": "resourcecontainers\r\n| where type == 'microsoft.resources/subscriptions'\r\n| where id == {Subscriptions}\r\n| project subscriptionId",
            "crossComponentResources": [
              "{Subscriptions}"
            ],
            "queryType": 1,
            "resourceType": "microsoft.resourcegraph/resources",
            "value": null
          }
        ],
        "style": "pills",
        "queryType": 1,
        "resourceType": "microsoft.resourcegraph/resources"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "none"
      },
      "name": "parameters - 8 - Copier"
    },
    {
      "type": 1,
      "content": {
        "json": "###### Selectionnez un onglet pour afficher les détails correpondants.",
        "style": "info"
      },
      "conditionalVisibility": {
        "parameterName": "Help",
        "comparison": "isEqualTo",
        "value": "Yes"
      },
      "name": "text - Help file - Copier"
    },
    {
      "type": 11,
      "content": {
        "version": "LinkItem/1.0",
        "style": "tabs",
        "links": [
          {
            "id": "6c39af19-c572-49b5-8605-93a93b71daa8",
            "cellValue": "selectedTab",
            "linkTarget": "parameter",
            "linkLabel": "Overview",
            "subTarget": "overview",
            "style": "link"
          },
          {
            "id": "20fe2243-a00d-45c1-851c-9457edb17158",
            "cellValue": "selectedTab",
            "linkTarget": "parameter",
            "linkLabel": "Backups",
            "subTarget": "backups",
            "style": "link"
          }
        ]
      },
      "name": "links - 6",
      "styleSettings": {
        "padding": "0 0 20px 0"
      }
    },
    {
      "type": 1,
      "content": {
        "json": "## NoShow - Begin Overview"
      },
      "conditionalVisibility": {
        "parameterName": "noshow",
        "comparison": "isEqualTo",
        "value": "noshow"
      },
      "name": "text - NoShow Overview"
    },
    {
      "type": 1,
      "content": {
        "json": "### NoShow - Begin PaaS - Data"
      },
      "conditionalVisibility": {
        "parameterName": "noshow",
        "comparison": "isEqualTo",
        "value": "noshow"
      },
      "name": "text - NoShow Begin PaaS - Data"
    },
    {
      "type": 1,
      "content": {
        "json": "### Liste des bases de données"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "overview"
      },
      "name": "text - PaaS Text - Data - Details"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "resources \r\n| where type has 'microsoft.documentdb'\r\n\tor type has 'microsoft.sql'\r\n\tor type has 'microsoft.dbformysql'\r\n\tor type has 'microsoft.sql'\r\n    or type has 'microsoft.purview'\r\n    or type has 'microsoft.datafactory'\r\n\tor type has 'microsoft.analysisservices'\r\n\tor type has 'microsoft.datamigration'\r\n\tor type has 'microsoft.synapse'\r\n\tor type has 'microsoft.datafactory'\r\n\tor type has 'microsoft.kusto'\r\n    or type has 'microsoft.sqlvirtualmachine'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.documentdb/databaseaccounts', 'CosmosDB',\r\n\ttype =~ 'microsoft.sql/servers/databases', 'SQL DBs',\r\n\ttype =~ 'microsoft.dbformysql/servers', 'MySQL',\r\n\ttype =~ 'microsoft.sql/servers', 'SQL Servers',\r\n    type =~ 'microsoft.purview/accounts', 'Purview Accounts',\r\n\ttype =~ 'microsoft.synapse/workspaces/sqlpools', 'Synapse SQL Pools',\r\n\ttype =~ 'microsoft.kusto/clusters', 'ADX Clusters',\r\n\ttype =~ 'microsoft.datafactory/factories', 'Data Factories',\r\n\ttype =~ 'microsoft.synapse/workspaces', 'Synapse Workspaces',\r\n\ttype =~ 'microsoft.analysisservices/servers', 'Analysis Services Servers',\r\n\ttype =~ 'microsoft.datamigration/services', 'DB Migration Service',\r\n\ttype =~ 'microsoft.sql/managedinstances/databases', 'Managed Instance DBs',\r\n\ttype =~ 'microsoft.sql/managedinstances', 'Managed Instance',\r\n\ttype =~ 'microsoft.datamigration/services/projects', 'Data Migration Projects',\r\n\ttype =~ 'microsoft.sql/virtualclusters', 'SQL Virtual Clusters',\r\n    type =~ 'microsoft.sqlvirtualmachine', 'SQL on Virtual machine',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| summarize count() by type",
        "size": 1,
        "noDataMessage": "No resources found",
        "queryType": 1,
        "resourceType": "microsoft.resourcegraph/resources",
        "crossComponentResources": [
          "{Subscriptions}"
        ],
        "visualization": "tiles",
        "gridSettings": {
          "formatters": [
            {
              "columnMatch": "$gen_group",
              "formatter": 13,
              "formatOptions": {
                "linkTarget": null,
                "showIcon": true
              }
            },
            {
              "columnMatch": "Resource",
              "formatter": 5
            },
            {
              "columnMatch": "subscriptionId",
              "formatter": 5
            }
          ],
          "hierarchySettings": {
            "treeType": 1,
            "groupBy": [
              "subscriptionId"
            ],
            "expandTopLevel": true,
            "finalBy": "Resource"
          }
        },
        "tileSettings": {
          "titleContent": {
            "columnMatch": "type",
            "formatter": 1
          },
          "leftContent": {
            "columnMatch": "count_",
            "formatter": 12,
            "formatOptions": {
              "palette": "auto"
            },
            "numberFormat": {
              "unit": 17,
              "options": {
                "maximumSignificantDigits": 3,
                "maximumFractionDigits": 2
              }
            }
          },
          "showBorder": true,
          "sortCriteriaField": "count_",
          "sortOrderField": 2
        }
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "overview"
      },
      "name": "query - PaaS - Data Overview"
    },
    {
      "type": 1,
      "content": {
        "json": "### Vue detaillee\r\n\r\nCliquez sur \"View Details\" pour obtenir des informations complementaires"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "overview"
      },
      "name": "text - PaaS Text - Data - Details"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "resources \r\n| where type has 'microsoft.documentdb'\r\n\tor type has 'microsoft.sql'\r\n\tor type has 'microsoft.dbformysql'\r\n\tor type has 'microsoft.sql'\r\n    or type has 'microsoft.purview'\r\n    or type has 'microsoft.datafactory'\r\n\tor type has 'microsoft.analysisservices'\r\n\tor type has 'microsoft.datamigration'\r\n\tor type has 'microsoft.synapse'\r\n\tor type has 'microsoft.datafactory'\r\n\tor type has 'microsoft.kusto'\r\n    or type has 'microsoft.sqlvirtualmachine'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.documentdb/databaseaccounts', 'CosmosDB',\r\n\ttype =~ 'microsoft.sql/servers/databases', 'SQL DBs',\r\n\ttype =~ 'microsoft.dbformysql/servers', 'MySQL',\r\n\ttype =~ 'microsoft.sql/servers', 'SQL Servers',\r\n    type =~ 'microsoft.purview/accounts', 'Purview Accounts',\r\n\ttype =~ 'microsoft.synapse/workspaces/sqlpools', 'Synapse SQL Pools',\r\n\ttype =~ 'microsoft.kusto/clusters', 'ADX Clusters',\r\n\ttype =~ 'microsoft.datafactory/factories', 'Data Factories',\r\n\ttype =~ 'microsoft.synapse/workspaces', 'Synapse Workspaces',\r\n\ttype =~ 'microsoft.analysisservices/servers', 'Analysis Services Servers',\r\n\ttype =~ 'microsoft.datamigration/services', 'DB Migration Service',\r\n\ttype =~ 'microsoft.sql/managedinstances/databases', 'Managed Instance DBs',\r\n\ttype =~ 'microsoft.sql/managedinstances', 'Managed Instance',\r\n\ttype =~ 'microsoft.datamigration/services/projects', 'Data Migration Projects',\r\n\ttype =~ 'microsoft.sql/virtualclusters', 'SQL Virtual Clusters',\r\n    type =~ 'microsoft.sqlvirtualmachine', 'SQL on Virtual machine',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| extend Sku = case(\r\n\ttype =~ 'CosmosDB', properties.databaseAccountOfferType,\r\n\ttype =~ 'SQL DBs', sku.name,\r\n\ttype =~ 'MySQL', sku.name,\r\n\ttype =~ 'ADX Clusters', sku.name,\r\n\ttype =~ 'Purview Accounts', sku.name,\r\n\t' ')\r\n| extend Status = case(\r\n\ttype =~ 'CosmosDB', properties.provisioningState,\r\n\ttype =~ 'SQL DBs', properties.status,\r\n\ttype =~ 'MySQL', properties.userVisibleState,\r\n\ttype =~ 'Managed Instance DBs', properties.status,\r\n\t' ')\r\n| extend Endpoint = case(\r\n\ttype =~ 'MySQL', properties.fullyQualifiedDomainName,\r\n\ttype =~ 'SQL Servers', properties.fullyQualifiedDomainName,\r\n\ttype =~ 'CosmosDB', properties.documentEndpoint,\r\n\ttype =~ 'ADX Clusters', properties.uri,\r\n\ttype =~ 'Purview Accounts', properties.endpoints,\r\n\ttype =~ 'Synapse Workspaces', properties.connectivityEndpoints,\r\n\ttype =~ 'Synapse SQL Pools', sku.name,\r\n\t' ')\r\n| extend Tier = sku.tier\r\n| extend License = properties.licenseType\r\n| extend maxSizeGB = todouble(case(\r\n\ttype =~ 'SQL DBs', properties.maxSizeBytes,\r\n\ttype =~ 'MySQL', properties.storageProfile.storageMB,\r\n\ttype =~ 'Synapse SQL Pools', properties.maxSizeBytes,\r\n\t' '))\r\n| extend maxSizeGB = case(\r\n\t\ttype has 'SQL DBs', maxSizeGB /1024 /1024 /1024,\r\n\t\ttype has 'Synapse SQL Pools', maxSizeGB /1024 /1024 /1024,\r\n\t\ttype has 'MySQL', maxSizeGB /1024,\r\n\t\tmaxSizeGB)\r\n| extend ServeurDb = case (type == 'SQL DBs',split(id,'/')[-3],'--')\r\n| extend BackupRedundancy = case (\r\n        type == 'SQL DBs',properties.storageAccountType,\r\n        type == 'CosmosDB',properties.backupPolicy.periodicModeProperties.backupStorageRedundancy,\r\n        '--')\r\n| extend BackupCompleteIntervalInMinutes = case (\r\ntype == 'CosmosDB',properties.backupPolicy.periodicModeProperties.backupIntervalInMinutes,\r\ntype == 'SQL DBs', '7j','--')\r\n| extend BackupRetentionIntervalInHours = case (\r\ntype == 'CosmosDB',properties.backupPolicy.periodicModeProperties.backupRetentionIntervalInHours,\r\ntype == 'SQL DBs' and (Tier == 'Basic' or Tier == 'System'), '7j',\r\ntype == 'SQL DBs' and Tier != 'Basic', '35j','--')\r\n| extend Details = pack_all()\r\n| join kind= inner (resourcecontainers\r\n| where type == 'microsoft.resources/subscriptions'\r\n| project subscriptionId, subscriptionName=name) on $left.subscriptionId == $right.subscriptionId\r\n| project Resource=id, resourceGroup, subscriptionId, subscriptionName, type, kind, Sku, Tier, Status, Endpoint, ServeurDb, maxSizeGB, BackupRedundancy, BackupCompleteIntervalInMinutes, BackupRetentionIntervalInHours, Details",
        "size": 2,
        "noDataMessage": "No resources found",
        "showExportToExcel": true,
        "queryType": 1,
        "resourceType": "microsoft.resourcegraph/resources",
        "crossComponentResources": [
          "{Subscriptions}"
        ],
        "gridSettings": {
          "formatters": [
            {
              "columnMatch": "$gen_group",
              "formatter": 13,
              "formatOptions": {
                "linkTarget": "Resource",
                "showIcon": true
              }
            },
            {
              "columnMatch": "Resource",
              "formatter": 5
            },
            {
              "columnMatch": "subscriptionId",
              "formatter": 5
            },
            {
              "columnMatch": "Tier",
              "formatter": 1
            },
            {
              "columnMatch": "maxSizeGB",
              "formatter": 0,
              "numberFormat": {
                "unit": 5,
                "options": {
                  "style": "decimal",
                  "useGrouping": false
                }
              }
            },
            {
              "columnMatch": "Details",
              "formatter": 7,
              "formatOptions": {
                "linkTarget": "CellDetails",
                "linkLabel": "View Details",
                "linkIsContextBlade": true
              }
            }
          ],
          "rowLimit": 1000,
          "filter": true,
          "hierarchySettings": {
            "treeType": 1,
            "groupBy": [
              "subscriptionId"
            ],
            "expandTopLevel": true,
            "finalBy": "Resource"
          }
        },
        "tileSettings": {
          "titleContent": {
            "columnMatch": "type",
            "formatter": 1
          },
          "leftContent": {
            "columnMatch": "count_",
            "formatter": 12,
            "formatOptions": {
              "palette": "auto"
            },
            "numberFormat": {
              "unit": 17,
              "options": {
                "maximumSignificantDigits": 3,
                "maximumFractionDigits": 2
              }
            }
          },
          "showBorder": true,
          "sortCriteriaField": "count_",
          "sortOrderField": 2
        }
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "overview"
      },
      "name": "query - PaaS - Data Detailed",
      "styleSettings": {
        "padding": "0 0 200px 0"
      }
    },
    {
      "type": 1,
      "content": {
        "json": "### NoShow - End PaaS - Data"
      },
      "conditionalVisibility": {
        "parameterName": "noshow",
        "comparison": "isEqualTo",
        "value": "noshow"
      },
      "name": "text - NoShow End PaaS - Data"
    },
    {
      "type": 1,
      "content": {
        "json": "### NoShow - Begin PaaS - Storage"
      },
      "conditionalVisibility": {
        "parameterName": "noshow",
        "comparison": "isEqualTo",
        "value": "noshow"
      },
      "name": "text - NoShow Begin PaaS - Storage"
    },
    {
      "type": 1,
      "content": {
        "json": "__________________________________________________________________________________________"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "overview"
      },
      "name": "Overview-DividingLine2",
      "styleSettings": {
        "padding": "0px 0px 10px 0px"
      }
    },
    {
      "type": 1,
      "content": {
        "json": "### Liste des Key Vaults et Recovery Services Vaults et Backup Vaults"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "overview"
      },
      "name": "text - PaaS Text - Data - Details"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "resources \r\n| where type =~ 'microsoft.storagesync/storagesyncservices'\r\n\tor type =~ 'microsoft.recoveryservices/vaults'\r\n    or type =~ 'Microsoft.DataProtection/backupVaults'\r\n\t//or type =~ 'microsoft.storage/storageaccounts'\r\n\tor type =~ 'microsoft.keyvault/vaults'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.storagesync/storagesyncservices', 'Azure File Sync',\r\n\ttype =~ 'microsoft.recoveryservices/vaults', 'RecoveryServices Vault',\r\n    type =~ 'Microsoft.DataProtection/backupVaults', 'Backup Vault',\r\n\t//type =~ 'microsoft.storage/storageaccounts', 'Storage Accounts',\r\n\ttype =~ 'microsoft.keyvault/vaults', 'Key Vaults',\r\n\tstrcat(\"Not Translated: \", type))\r\n| where type !has \"Not Translated\"\r\n| summarize count() by type",
        "size": 1,
        "noDataMessage": "No resources found",
        "queryType": 1,
        "resourceType": "microsoft.resourcegraph/resources",
        "crossComponentResources": [
          "{Subscriptions}"
        ],
        "visualization": "tiles",
        "gridSettings": {
          "formatters": [
            {
              "columnMatch": "$gen_group",
              "formatter": 13,
              "formatOptions": {
                "linkTarget": null,
                "showIcon": true
              }
            },
            {
              "columnMatch": "Resource",
              "formatter": 5
            },
            {
              "columnMatch": "subscriptionId",
              "formatter": 5
            }
          ],
          "hierarchySettings": {
            "treeType": 1,
            "groupBy": [
              "subscriptionId"
            ],
            "expandTopLevel": true,
            "finalBy": "Resource"
          }
        },
        "tileSettings": {
          "titleContent": {
            "columnMatch": "type",
            "formatter": 1
          },
          "leftContent": {
            "columnMatch": "count_",
            "formatter": 12,
            "formatOptions": {
              "palette": "auto"
            },
            "numberFormat": {
              "unit": 17,
              "options": {
                "maximumSignificantDigits": 3,
                "maximumFractionDigits": 2
              }
            }
          },
          "showBorder": true,
          "sortCriteriaField": "count_",
          "sortOrderField": 2
        }
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "overview"
      },
      "name": "query - PaaS - Data Overview "
    },
    {
      "type": 1,
      "content": {
        "json": "### Vue detaillee\r\n\r\nCliquez sur \"View Details\" pour obtenir des informations complementaires"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "overview"
      },
      "name": "text - PaaS Text - Storage - Details"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "resources \r\n| where type =~ 'microsoft.storagesync/storagesyncservices'\r\n\tor type =~ 'microsoft.recoveryservices/vaults'\r\n    or type =~ 'Microsoft.DataProtection/backupVaults'\r\n\t//or type =~ 'microsoft.storage/storageaccounts'\r\n\tor type =~ 'microsoft.keyvault/vaults'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.storagesync/storagesyncservices', 'Azure File Sync',\r\n\ttype =~ 'microsoft.recoveryservices/vaults', 'RecoveryServices Vault',\r\n    type =~ 'Microsoft.DataProtection/backupVaults', 'Backup Vault',\r\n\t//type =~ 'microsoft.storage/storageaccounts', 'Storage Accounts',\r\n\ttype =~ 'microsoft.keyvault/vaults', 'Key Vaults',\r\n\tstrcat(\"Not Translated: \", type))\r\n| extend Sku = case(\r\n\ttype !has 'Key Vaults', sku.name,\r\n\ttype =~ 'Key Vaults', properties.sku.name,\r\n\t' ')\r\n| extend Details = pack_all()\r\n| join kind= inner (resourcecontainers\r\n| where type == 'microsoft.resources/subscriptions'\r\n| project subscriptionId, subscriptionName=name) on $left.subscriptionId == $right.subscriptionId\r\n| project Resource=id, type, kind, subscriptionId, subscriptionName, resourceGroup, Sku, Details",
        "size": 2,
        "noDataMessage": "No resources found",
        "showExportToExcel": true,
        "queryType": 1,
        "resourceType": "microsoft.resourcegraph/resources",
        "crossComponentResources": [
          "{Subscriptions}"
        ],
        "gridSettings": {
          "formatters": [
            {
              "columnMatch": "$gen_group",
              "formatter": 13,
              "formatOptions": {
                "linkTarget": "Resource",
                "showIcon": true
              }
            },
            {
              "columnMatch": "Resource",
              "formatter": 5
            },
            {
              "columnMatch": "subscriptionId",
              "formatter": 5
            },
            {
              "columnMatch": "Details",
              "formatter": 7,
              "formatOptions": {
                "linkTarget": "CellDetails",
                "linkLabel": "View Details",
                "linkIsContextBlade": true
              }
            }
          ],
          "rowLimit": 1000,
          "filter": true,
          "hierarchySettings": {
            "treeType": 1,
            "groupBy": [
              "subscriptionId"
            ],
            "expandTopLevel": true,
            "finalBy": "Resource"
          }
        }
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "overview"
      },
      "name": "query - PaaS - Data Detailed",
      "styleSettings": {
        "padding": "0 0 200px 0"
      }
    },
    {
      "type": 1,
      "content": {
        "json": "### NoShow - End PaaS - Storage"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "none"
      },
      "name": "text - NoShow End PaaS - Storage - Copy"
    },
    {
      "type": 1,
      "content": {
        "json": "### NoShow - Begin PaaS - Storage Account"
      },
      "conditionalVisibility": {
        "parameterName": "noshow",
        "comparison": "isEqualTo",
        "value": "noshow"
      },
      "name": "text - NoShow Begin PaaS - Storage Account"
    },
    {
      "type": 1,
      "content": {
        "json": "### Répartition geographique des storage accounts"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "overview"
      },
      "name": "Répartition geographique des storage accounts"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": " Resources\r\n  | where type =~ 'microsoft.storage/storageaccounts'\r\n  //| where resourceGroup notcontains 'databricks'\r\n  | summarize [\"Number of Resources\"] = count() by [\"Location\"] =  location",
        "size": 2,
        "exportFieldName": "Location",
        "exportParameterName": "location",
        "exportToExcelOptions": "all",
        "queryType": 1,
        "resourceType": "microsoft.resourcegraph/resources",
        "crossComponentResources": [
          "value::all"
        ],
        "visualization": "map",
        "tileSettings": {
          "showBorder": false,
          "titleContent": {
            "columnMatch": "Location",
            "formatter": 1
          },
          "leftContent": {
            "columnMatch": "Number of Resources",
            "formatter": 12,
            "formatOptions": {
              "palette": "auto"
            },
            "numberFormat": {
              "unit": 17,
              "options": {
                "maximumSignificantDigits": 3,
                "maximumFractionDigits": 2
              }
            }
          }
        },
        "mapSettings": {
          "locInfo": "AzureLoc",
          "locInfoColumn": "Location",
          "sizeSettings": "Number of Resources",
          "sizeAggregation": "Sum",
          "labelSettings": "Location",
          "legendMetric": "Number of Resources",
          "legendAggregation": "Sum",
          "itemColorSettings": {
            "nodeColorField": "Number of Resources",
            "colorAggregation": "Sum",
            "type": "heatmap",
            "heatmapPalette": "yellowOrangeBrown"
          }
        }
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "overview"
      },
      "customWidth": "70",
      "name": "Maps - Repartition Geographique des storages accounts avec leurs performances"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "resources\r\n| where type =~ 'microsoft.storage/storageaccounts'\r\n| extend Redondance=sku.name\r\n| extend Type_Acces=properties.accessTier\r\n| extend statusOfPrimary=properties.statusOfPrimary\r\n| extend SecondaryLocation=properties.secondaryLocation\r\n| extend statusOfSecondary=properties.statusOfSecondary\r\n| extend Details = pack_all()\r\n| join kind= inner (resourcecontainers\r\n| where type == 'microsoft.resources/subscriptions'\r\n| project subscriptionId, subscriptionName=name) on $left.subscriptionId == $right.subscriptionId\r\n| project id, name, subscriptionId,subscriptionName, kind, Redondance, Type_Acces, PrimaryLocation=location, statusOfPrimary, SecondaryLocation, statusOfSecondary, resourceGroup, sku.name, Tags=tostring(tags), Details",
        "size": 2,
        "noDataMessage": "No storage account found",
        "noDataMessageStyle": 3,
        "showExportToExcel": true,
        "queryType": 1,
        "resourceType": "microsoft.resourcegraph/resources",
        "crossComponentResources": [
          "{Subscriptions}"
        ],
        "visualization": "table",
        "gridSettings": {
          "formatters": [
            {
              "columnMatch": "$gen_group",
              "formatter": 13,
              "formatOptions": {
                "linkTarget": "Resource",
                "showIcon": true
              }
            },
            {
              "columnMatch": "id",
              "formatter": 5
            },
            {
              "columnMatch": "subscriptionId",
              "formatter": 5
            },
            {
              "columnMatch": "sku_name",
              "formatter": 1
            },
            {
              "columnMatch": "Details",
              "formatter": 7,
              "formatOptions": {
                "linkTarget": "CellDetails",
                "linkLabel": "View Details",
                "linkIsContextBlade": true
              }
            }
          ],
          "rowLimit": 1000,
          "filter": true,
          "hierarchySettings": {
            "treeType": 1,
            "groupBy": [
              "subscriptionId"
            ],
            "expandTopLevel": true,
            "finalBy": "id"
          }
        }
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "overview"
      },
      "name": "query - Azure Compute Storage Account",
      "styleSettings": {
        "padding": "0 0 200px 0"
      }
    },
    {
      "type": 1,
      "content": {
        "json": "### NoShow - Begin Backup"
      },
      "conditionalVisibility": {
        "parameterName": "noshow",
        "comparison": "isEqualTo",
        "value": "noshow"
      },
      "name": "text - NoShow Begin Backup"
    },
    {
      "type": 1,
      "content": {
        "json": "### BACKUPS SQL Databases"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "text - PaaS Text - Data - Details"
    },
    {
      "type": 1,
      "content": {
        "json": "Les backups de SQL Databases (PaaS) sont **automatiquement** gérées par Azure. \r\n\r\n|Type|Frequence|\r\n|---|---|\r\n|Completes| 7j |\r\n|Différentielles| entre 12h & 24h|\r\n|Journaux transactions| 10 min| \r\n\r\n",
        "style": "info"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "text - Help file - Copier"
    },
    {
      "type": 1,
      "content": {
        "json": "Les **retentions cour-terme** des backups de SQL Databases (PaaS) par défaut sont : \r\n\r\n|Service Tier|Frequence|\r\n|---|---|\r\n|Basique| 7j |\r\n|Standard| 35j |\r\n|Premium| 35j | \r\n\r\n",
        "style": "info"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "text - Help file - Copier - Copier"
    },
    {
      "type": 1,
      "content": {
        "json": "Les **retentions long-terme** des backups de SQL Databases (PaaS) ne sont **pas activées** par défaut. Il est cependant possible de planifier des retentions de sauvegardes **completes** sur plus long terme.",
        "style": "info"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "text - Help file - Copier - Copier - Copier"
    },
    {
      "type": 1,
      "content": {
        "json": "Les **redondance des sauvegardes** SQL Databases (PaaS) est de type **GRS** par défaut (Géo-redondant). Il est nénamoins possible de personnaliser cette redondance avec LRS ou ZRS.",
        "style": "info"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "text - Help file - Copier - Copier - Copier - Copier"
    },
    {
      "type": 1,
      "content": {
        "json": "L'overview des ressources propose certaines informations quant à la redondance, la durée de rentention court termes, ou l'intervalle de temps entre 2 sauvegardes completes d'une SQL Database : ces informations ne font pas apparaitre des informations indispensables comme \r\n- la date de restauration possible la plus ancienne (PITR)\r\n- les eventuelles personnalisations des durée de retentions court-terme\r\n- les eventuelles personnalisations des durée de retentions long-terme\r\n\r\nCes informations **ne sont pas accessibles directement** sur un Workbook => merci d'utiliser le script Powershell \"State Of Backups SQL.ps1\"",
        "style": "info"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "text - Help file - Copier - Copier - Copier - Copier - Copier"
    },
    {
      "type": 1,
      "content": {
        "json": "__________________________________________________________________________________________"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "backup-DividingLine2",
      "styleSettings": {
        "padding": "0px 0px 10px 0px"
      }
    },
    {
      "type": 1,
      "content": {
        "json": "### BACKUPS COSMOSDB Databases"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "text - PaaS Text - Data - Details"
    },
    {
      "type": 1,
      "content": {
        "json": "Les backups de COSMOSDB Databases (PaaS) sont **automatiquement** gérées par Azure, avec **uniquement** des **sauvegardes complètes** (stockées dans un blob storage sous forme d'instantané),séparées par un intervalle de **4 heures** par défaut. \r\n\r\n|Intervalle Mini|Intervalle par défaut|Intervalle Maxi|\r\n|---|---|\r\n| 1 heure | 240 min (4 heures) | 24 heures|\r\n\r\n",
        "style": "info"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "text - Help file - Copier"
    },
    {
      "type": 1,
      "content": {
        "json": "Les **retentions court-terme** des backups de COSMOSDB Databases (PaaS) par défaut se limitent à 2 dernieres sauvegardes => la durée de retention est donc compris entre 2x l'intervalle de sauvegarde (4h) et 730 heures (30j) : \r\n\r\n|Durée de retention Mini|Durée de retention par défaut| Durée de retention Maxi|\r\n|---|---|---|\r\n|2x l'intervalle de sauvegarde (=> 8h)|2x l'intervalle de sauvegarde (=> 8h)| 720 heures (30 jours) |\r\n\r\n\r\n",
        "style": "info"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "text - Help file - Copier - Copier"
    },
    {
      "type": 1,
      "content": {
        "json": "Les **retentions long-terme** des COSMOSDB Databases (PaaS) ne sont **pas activables**.",
        "style": "info"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "text - Help file - Copier - Copier - Copier"
    },
    {
      "type": 1,
      "content": {
        "json": "Les **redondance des sauvegardes** COSMOSDB Databases (PaaS) est de type **GRS** par défaut (Géo-redondant). Il est nénamoins possible de personnaliser cette redondance avec LRS ou ZRS.",
        "style": "info"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "text - Help file - Copier - Copier - Copier - Copier"
    },
    {
      "type": 1,
      "content": {
        "json": "L'overview des ressources propose certaines informations quant à la redondance, la durée de rentention court termes, ou l'intervalle de temps entre 2 sauvegardes completes d'une COSMOSDB Databases : vous les retrouvez ci-dessous",
        "style": "info"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "text - Help file - Copier - Copier - Copier - Copier - Copier"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "resources \r\n| where type has 'microsoft.documentdb'\r\n| extend type = case(\r\n\ttype =~ 'microsoft.documentdb/databaseaccounts', 'CosmosDB', type)\r\n| where type !has \"Not Translated\"\r\n| extend Sku = case(\r\n\ttype =~ 'CosmosDB', properties.databaseAccountOfferType,\r\n\t' ')\r\n| extend Status = case(\r\n\ttype =~ 'CosmosDB', properties.provisioningState,\r\n\t' ')\r\n| extend Endpoint = case(\r\n\ttype =~ 'CosmosDB', properties.documentEndpoint,\r\n\t' ')\r\n| extend Tier = sku.tier\r\n| extend License = properties.licenseType\r\n| extend BackupRedundancy = case (\r\n        type == 'CosmosDB',properties.backupPolicy.periodicModeProperties.backupStorageRedundancy,\r\n        '--')\r\n| extend BackupCompleteIntervalInMinutes = case (\r\n    type == 'CosmosDB',properties.backupPolicy.periodicModeProperties.backupIntervalInMinutes,'--')\r\n| extend BackupRetentionIntervalInHours = case (\r\n    type == 'CosmosDB',properties.backupPolicy.periodicModeProperties.backupRetentionIntervalInHours,'--')\r\n| extend Details = pack_all()\r\n| join kind= inner (resourcecontainers\r\n| where type == 'microsoft.resources/subscriptions'\r\n| project subscriptionId, subscriptionName=name) on $left.subscriptionId == $right.subscriptionId\r\n| project Resource=id, resourceGroup, subscriptionId, subscriptionName, type, kind, Sku, Tier, Status, Endpoint, BackupRedundancy, BackupCompleteIntervalInMinutes, BackupRetentionIntervalInHours, Details\r\n\r\n",
        "size": 2,
        "title": "CosmosDb Backups state",
        "showExportToExcel": true,
        "queryType": 1,
        "resourceType": "microsoft.resourcegraph/resources",
        "crossComponentResources": [
          "{Subscriptions}"
        ],
        "gridSettings": {
          "formatters": [
            {
              "columnMatch": "$gen_group",
              "formatter": 13,
              "formatOptions": {
                "linkTarget": "Resource",
                "showIcon": true
              }
            },
            {
              "columnMatch": "Resource",
              "formatter": 5
            },
            {
              "columnMatch": "subscriptionId",
              "formatter": 5
            },
            {
              "columnMatch": "Tier",
              "formatter": 1
            },
            {
              "columnMatch": "maxSizeGB",
              "formatter": 0,
              "numberFormat": {
                "unit": 5,
                "options": {
                  "style": "decimal",
                  "useGrouping": false
                }
              }
            },
            {
              "columnMatch": "Details",
              "formatter": 7,
              "formatOptions": {
                "linkTarget": "CellDetails",
                "linkLabel": "View Details",
                "linkIsContextBlade": true
              }
            }
          ],
          "rowLimit": 1000,
          "filter": true,
          "hierarchySettings": {
            "treeType": 1,
            "groupBy": [
              "subscriptionId"
            ],
            "expandTopLevel": true,
            "finalBy": "Resource"
          }
        },
        "tileSettings": {
          "titleContent": {
            "columnMatch": "type",
            "formatter": 1
          },
          "leftContent": {
            "columnMatch": "count_",
            "formatter": 12,
            "formatOptions": {
              "palette": "auto"
            },
            "numberFormat": {
              "unit": 17,
              "options": {
                "maximumSignificantDigits": 3,
                "maximumFractionDigits": 2
              }
            }
          },
          "showBorder": true,
          "sortCriteriaField": "count_",
          "sortOrderField": 2
        }
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "query - PaaS - Data Detailed",
      "styleSettings": {
        "padding": "0 0 200px 0"
      }
    },
    {
      "type": 1,
      "content": {
        "json": "__________________________________________________________________________________________"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "backup-DividingLine2",
      "styleSettings": {
        "padding": "0px 0px 10px 0px"
      }
    },
    {
      "type": 1,
      "content": {
        "json": "### BACKUPS STORAGE ACCOUNTS"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "text - PaaS Text - Data - Details"
    },
    {
      "type": 1,
      "content": {
        "json": "Les backups de STORAGE ACCOUNTS s'apparente à une solution de protection de données, plutot qu'à une sauvegarde à proprement parlé.\r\nCette sauvegarde opérationnelle d’objets blob est une solution de sauvegarde **locale**. Les données de sauvegarde ne sont donc pas transférées dans le coffre de sauvegarde, mais stockées dans le compte de stockage source proprement dit. Toutefois, le coffre de sauvegarde sert quand même d’unité de gestion des sauvegardes. Il s’agit aussi d’une solution de sauvegarde continue, ce qui signifie qu’il n’est pas nécessaire de planifier des sauvegardes ; toutes les modifications sont conservées et peuvent être restaurées à leur état à un moment donné (PITR : Point In Time Restore).\r\nSoft Delete, Controle de version et flux de modification sont des pré-requis à une restauration dans le temps : c'est pourquoi ils sont completés/activés **par défaut** dès qu'une PITR est activée\r\n\r\n|PITR|Soft Delete|Controle de version|Flux de modification|\r\n|---|---|---|\r\n| n jours | (n + 5) jours | Activé si PITR > 0| Activé si PITR > 0 |",
        "style": "info"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "text - Help file - Copier"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "RecoveryServicesResources\r\n| where type == 'microsoft.dataprotection/backupvaults/backuppolicies'// and name == 'StrategieSauvegardeVMsProduction'\r\n| extend vaultName = split(split(id, '/Microsoft.DataProtection/backupVaults/')[1],'/')[0]\r\n| extend DataSourceType = properties.datasourceTypes[0]\r\n| extend MRP = substring(properties.policyRules[0].lifecycles[0].deleteAfter.duration,1,2)\r\n| extend MaximalRestaurationPoint = case ((isnull(MRP) or MRP=='null' or MRP==''), '--', strcat(MRP, ' jours'))\r\n| extend SROB = toint(MRP)+5\r\n| extend SRC = 7\r\n| extend SuppressionReversibleObjetsBlob = case ((isnull(MRP) or MRP=='null' or MRP==''), '--', strcat(SROB, ' jours'))\r\n| extend SuppressionReversibleConteneurs = case ((isnull(MRP) or MRP=='null' or MRP==''), '--', strcat(SRC, ' jours'))\r\n| extend GestiondesVersions = case ((isnull(MRP) or MRP=='null' or MRP==''), 'Non','Oui')\r\n| extend FluxdeMmodification = case ((isnull(MRP) or MRP=='null' or MRP==''), 'Non','Oui')\r\n| project id, name, resourceGroup, vaultName, DataSourceType, MaximalRestaurationPoint, SuppressionReversibleObjetsBlob, SuppressionReversibleConteneurs, GestiondesVersions, FluxdeMmodification\r\n",
        "size": 0,
        "queryType": 1,
        "resourceType": "microsoft.resourcegraph/resources",
        "crossComponentResources": [
          "{Subscriptions}"
        ]
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "noe"
      },
      "name": "requête - Liste Policy Backup Vault"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "RecoveryServicesResources\r\n| where type == 'microsoft.dataprotection/backupvaults/backupinstances'// and name == 'StrategieSauvegardeVMsProduction'\r\n| extend ResourceName = properties.friendlyName\r\n| extend vaultName = split(split(id, '/Microsoft.DataProtection/backupVaults/')[1],'/')[0]\r\n| extend DataSourceType = properties.dataSourceSetInfo.datasourceType\r\n| extend Protection = properties.protectionStatus.status\r\n| project ResourceName, vaultName, DataSourceType, Protection\r\n",
        "size": 0,
        "queryType": 1,
        "resourceType": "microsoft.resourcegraph/resources",
        "crossComponentResources": [
          "{Subscriptions}"
        ]
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "none"
      },
      "name": "requête - Liste des instances par Vault"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "resources \r\n| where type =~ 'Microsoft.DataProtection/backupVaults'\r\n| extend type = case(type =~ 'Microsoft.DataProtection/backupVaults', 'Backup Vault', type)\r\n| extend Sku = case(\r\n\ttype !has 'Key Vaults', sku.name,\r\n\ttype =~ 'Key Vaults', properties.sku.name,\r\n\t' ')\r\n| extend Details = pack_all()\r\n| join kind= inner (resourcecontainers\r\n| where type == 'microsoft.resources/subscriptions'\r\n| project subscriptionId, subscriptionName=name) on $left.subscriptionId == $right.subscriptionId\r\n| project Resource=id, name, type, kind, subscriptionId, subscriptionName, resourceGroup, Sku, Details",
        "size": 2,
        "noDataMessage": "No resources found",
        "showExportToExcel": true,
        "queryType": 1,
        "resourceType": "microsoft.resourcegraph/resources",
        "crossComponentResources": [
          "{Subscriptions}"
        ],
        "gridSettings": {
          "formatters": [
            {
              "columnMatch": "$gen_group",
              "formatter": 13,
              "formatOptions": {
                "linkTarget": "Resource",
                "showIcon": true
              }
            },
            {
              "columnMatch": "Resource",
              "formatter": 5
            },
            {
              "columnMatch": "name",
              "formatter": 5
            },
            {
              "columnMatch": "subscriptionId",
              "formatter": 5
            },
            {
              "columnMatch": "Details",
              "formatter": 7,
              "formatOptions": {
                "linkTarget": "CellDetails",
                "linkLabel": "View Details",
                "linkIsContextBlade": true
              }
            }
          ],
          "rowLimit": 1000,
          "filter": true,
          "hierarchySettings": {
            "treeType": 1,
            "groupBy": [
              "subscriptionId"
            ],
            "expandTopLevel": true,
            "finalBy": "Resource"
          }
        }
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "none"
      },
      "name": "query - Backup Vault",
      "styleSettings": {
        "padding": "0 0 200px 0"
      }
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "RecoveryServicesResources\r\n| where type == 'microsoft.dataprotection/backupvaults/backupinstances'// and name == 'StrategieSauvegardeVMsProduction'\r\n| extend type = 'Backupés'\r\n| summarize count() by type\r\n",
        "size": 4,
        "queryType": 1,
        "resourceType": "microsoft.resourcegraph/resources",
        "crossComponentResources": [
          "{Subscriptions}"
        ],
        "visualization": "tiles",
        "tileSettings": {
          "titleContent": {
            "columnMatch": "type",
            "formatter": 1
          },
          "leftContent": {
            "columnMatch": "count_",
            "formatter": 12,
            "formatOptions": {
              "min": 28,
              "max": 29,
              "palette": "green"
            },
            "numberFormat": {
              "unit": 17,
              "options": {
                "style": "decimal",
                "maximumFractionDigits": 2,
                "maximumSignificantDigits": 3
              }
            }
          },
          "showBorder": false
        }
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "customWidth": "20",
      "name": "requête - Comptage Storage Accounts backupés"
    },
    {
      "type": 9,
      "content": {
        "version": "KqlParameterItem/1.0",
        "crossComponentResources": [
          "{Subscriptions}"
        ],
        "parameters": [
          {
            "id": "8b5c61aa-24b8-4fae-93d9-1e732e488bc8",
            "version": "KqlParameterItem/1.0",
            "name": "NbStorageAccounts",
            "type": 1,
            "query": "resources\r\n| where type =~ 'microsoft.storage/storageaccounts'\r\n| summarize count() by type\r\n| project count_",
            "crossComponentResources": [
              "{Subscriptions}"
            ],
            "timeContext": {
              "durationMs": 86400000
            },
            "queryType": 1,
            "resourceType": "microsoft.resourcegraph/resources"
          }
        ],
        "style": "pills",
        "queryType": 1,
        "resourceType": "microsoft.resourcegraph/resources"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "none"
      },
      "name": "paramètres - 58"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "RecoveryServicesResources\r\n| where type == 'microsoft.dataprotection/backupvaults/backupinstances'// and name == 'StrategieSauvegardeVMsProduction'\r\n//| extend type = 'Storage Account Backupés'\r\n| summarize count() by type\r\n| project NbBackupes=count_\r\n| extend StorageAccountsNonBackupes = toint({NbStorageAccounts}) - toint(NbBackupes)\r\n| project title='NonBackupes', StorageAccountsNonBackupes",
        "size": 4,
        "queryType": 1,
        "resourceType": "microsoft.resourcegraph/resources",
        "crossComponentResources": [
          "{Subscriptions}"
        ],
        "visualization": "tiles",
        "tileSettings": {
          "titleContent": {
            "columnMatch": "title",
            "formatter": 1
          },
          "leftContent": {
            "columnMatch": "StorageAccountsNonBackupes",
            "formatter": 12,
            "formatOptions": {
              "min": 180,
              "max": 182,
              "palette": "red"
            },
            "numberFormat": {
              "unit": 17,
              "options": {
                "style": "decimal"
              }
            }
          },
          "showBorder": false
        }
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "customWidth": "20",
      "name": "requête - Comptage Non backupes"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "resources\r\n| where type =~ 'microsoft.storage/storageaccounts'\r\n| extend Redondance=sku.name\r\n| extend Type_Acces=properties.accessTier\r\n| extend statusOfPrimary=properties.statusOfPrimary\r\n| extend SecondaryLocation=properties.secondaryLocation\r\n| extend statusOfSecondary=properties.statusOfSecondary\r\n| extend Details = pack_all()\r\n| join kind= inner (resourcecontainers\r\n| where type == 'microsoft.resources/subscriptions'\r\n| project subscriptionId, subscriptionName=name) on $left.subscriptionId == $right.subscriptionId\r\n| project id, name, subscriptionId, subscriptionName, kind, Redondance, Type_Acces, PrimaryLocation=location, statusOfPrimary, SecondaryLocation, statusOfSecondary, resourceGroup, sku.name, Tags=tostring(tags), Details",
        "size": 2,
        "noDataMessage": "No storage account found",
        "noDataMessageStyle": 3,
        "showExportToExcel": true,
        "queryType": 1,
        "resourceType": "microsoft.resourcegraph/resources",
        "crossComponentResources": [
          "{Subscriptions}"
        ],
        "visualization": "table",
        "gridSettings": {
          "formatters": [
            {
              "columnMatch": "$gen_group",
              "formatter": 13,
              "formatOptions": {
                "linkTarget": "Resource",
                "showIcon": true
              }
            },
            {
              "columnMatch": "id",
              "formatter": 5
            },
            {
              "columnMatch": "subscriptionId",
              "formatter": 5
            },
            {
              "columnMatch": "sku_name",
              "formatter": 1
            },
            {
              "columnMatch": "Details",
              "formatter": 7,
              "formatOptions": {
                "linkTarget": "CellDetails",
                "linkLabel": "View Details",
                "linkIsContextBlade": true
              }
            }
          ],
          "rowLimit": 1000,
          "filter": true,
          "hierarchySettings": {
            "treeType": 1,
            "groupBy": [
              "subscriptionId"
            ],
            "expandTopLevel": true,
            "finalBy": "id"
          }
        }
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "none"
      },
      "name": "query - Liste basique Storage Account",
      "styleSettings": {
        "padding": "0 0 200px 0"
      }
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "{\"version\":\"Merge/1.0\",\"merges\":[{\"id\":\"1a538287-10b7-4421-b00c-221c5d9a7281\",\"mergeType\":\"inner\",\"leftTable\":\"requête - Liste des instances par Vault\",\"rightTable\":\"query - Backup Vault\",\"leftColumn\":\"vaultName\",\"rightColumn\":\"name\"},{\"id\":\"1a538287-10b7-4421-b00c-221c5d9a7289\",\"mergeType\":\"inner\",\"leftTable\":\"query - Backup Vault\",\"rightTable\":\"requête - Liste Policy Backup Vault\",\"leftColumn\":\"name\",\"rightColumn\":\"vaultName\"}],\"projectRename\":[{\"originalName\":\"[query - Backup Vault].subscriptionId\",\"mergedName\":\"subscriptionId\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a7281\"},{\"originalName\":\"[query - Backup Vault].name\",\"mergedName\":\"name\",\"fromId\":\"unknown\"},{\"originalName\":\"[requête - Liste des instances par Vault].ResourceName\",\"mergedName\":\"Storage Account\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a7281\"},{\"originalName\":\"[requête - Liste des instances par Vault].vaultName\",\"mergedName\":\"Coffre\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a7281\"},{\"originalName\":\"[requête - Liste Policy Backup Vault].name\",\"mergedName\":\"Stratégie\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a7289\"},{\"originalName\":\"[requête - Liste Policy Backup Vault].vaultName\",\"mergedName\":\"vaultName1\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a7289\"},{\"originalName\":\"[requête - Liste Policy Backup Vault].DataSourceType\",\"mergedName\":\"DataSourceType\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a7289\"},{\"originalName\":\"[requête - Liste des instances par Vault].Protection\",\"mergedName\":\"Protection\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a7281\"},{\"originalName\":\"[query - Backup Vault].resourceGroup\",\"mergedName\":\"resourceGroup\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a7281\"},{\"originalName\":\"[query - Backup Vault].Details\",\"mergedName\":\"Details\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a7281\"},{\"originalName\":\"[requête - Liste Policy Backup Vault].MaximalRestaurationPoint\",\"mergedName\":\"MaximalRestaurationPoint\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a7289\"},{\"originalName\":\"[requête - Liste Policy Backup Vault].SuppressionReversibleObjetsBlob\",\"mergedName\":\"SuppressionReversibleObjetsBlob\",\"fromId\":\"unknown\"},{\"originalName\":\"[requête - Liste Policy Backup Vault].SuppressionReversibleConteneurs\",\"mergedName\":\"SuppressionReversibleConteneurs\",\"fromId\":\"unknown\"},{\"originalName\":\"[requête - Liste Policy Backup Vault].GestiondesVersions\",\"mergedName\":\"GestiondesVersions\",\"fromId\":\"unknown\"},{\"originalName\":\"[requête - Liste Policy Backup Vault].FluxdeMmodification\",\"mergedName\":\"FluxdeMmodification\",\"fromId\":\"unknown\"},{\"originalName\":\"[query - Backup Vault].subscriptionName\",\"mergedName\":\"subscriptionName\",\"fromId\":\"unknown\"},{\"originalName\":\"[query - Backup Vault].Resource\"},{\"originalName\":\"[query - Backup Vault].type\"},{\"originalName\":\"[query - Backup Vault].kind\"},{\"originalName\":\"[query - Backup Vault].Sku\"},{\"originalName\":\"[requête - Liste Policy Backup Vault].id\"},{\"originalName\":\"[requête - Liste Policy Backup Vault].resourceGroup\"},{\"originalName\":\"[requête - Liste des instances par Vault].DataSourceType\"}]}",
        "size": 0,
        "title": " Liste des storage account backupés",
        "showRefreshButton": true,
        "showExportToExcel": true,
        "queryType": 7,
        "gridSettings": {
          "formatters": [
            {
              "columnMatch": "$gen_group",
              "formatter": 13,
              "formatOptions": {
                "linkTarget": null,
                "showIcon": true
              }
            },
            {
              "columnMatch": "subscriptionId",
              "formatter": 5
            },
            {
              "columnMatch": "name",
              "formatter": 5
            },
            {
              "columnMatch": "Storage Account",
              "formatter": 1
            },
            {
              "columnMatch": "Coffre",
              "formatter": 1,
              "formatOptions": {
                "customColumnWidthSetting": "22ch"
              }
            },
            {
              "columnMatch": "Stratégie",
              "formatter": 0,
              "formatOptions": {
                "customColumnWidthSetting": "19.5714ch"
              }
            },
            {
              "columnMatch": "vaultName1",
              "formatter": 5
            },
            {
              "columnMatch": "Protection",
              "formatter": 18,
              "formatOptions": {
                "thresholdsOptions": "icons",
                "thresholdsGrid": [
                  {
                    "operator": "==",
                    "thresholdValue": "ProtectionConfigured",
                    "representation": "success",
                    "text": "{0}{1}"
                  },
                  {
                    "operator": "Default",
                    "thresholdValue": null,
                    "representation": "2",
                    "text": "{0}{1}"
                  }
                ]
              }
            },
            {
              "columnMatch": "Details",
              "formatter": 5
            },
            {
              "columnMatch": "MaximalRestaurationPoint",
              "formatter": 18,
              "formatOptions": {
                "thresholdsOptions": "icons",
                "thresholdsGrid": [
                  {
                    "operator": "contains",
                    "thresholdValue": "jour",
                    "representation": "success",
                    "text": "{0}{1}"
                  },
                  {
                    "operator": "Default",
                    "thresholdValue": null,
                    "representation": "4",
                    "text": "{0}{1}"
                  }
                ]
              }
            },
            {
              "columnMatch": "SuppressionReversibleObjetsBlob",
              "formatter": 18,
              "formatOptions": {
                "thresholdsOptions": "icons",
                "thresholdsGrid": [
                  {
                    "operator": "contains",
                    "thresholdValue": "jour",
                    "representation": "success",
                    "text": "{0}{1}"
                  },
                  {
                    "operator": "Default",
                    "thresholdValue": null,
                    "representation": "4",
                    "text": "{0}{1}"
                  }
                ]
              }
            },
            {
              "columnMatch": "SuppressionReversibleConteneurs",
              "formatter": 18,
              "formatOptions": {
                "thresholdsOptions": "icons",
                "thresholdsGrid": [
                  {
                    "operator": "contains",
                    "thresholdValue": "jour",
                    "representation": "success",
                    "text": "{0}{1}"
                  },
                  {
                    "operator": "Default",
                    "thresholdValue": null,
                    "representation": "4",
                    "text": "{0}{1}"
                  }
                ]
              }
            },
            {
              "columnMatch": "GestiondesVersions",
              "formatter": 18,
              "formatOptions": {
                "thresholdsOptions": "icons",
                "thresholdsGrid": [
                  {
                    "operator": "==",
                    "thresholdValue": "Oui",
                    "representation": "success",
                    "text": "{0}{1}"
                  },
                  {
                    "operator": "Default",
                    "thresholdValue": null,
                    "representation": "4",
                    "text": "{0}{1}"
                  }
                ]
              }
            },
            {
              "columnMatch": "FluxdeMmodification",
              "formatter": 18,
              "formatOptions": {
                "thresholdsOptions": "icons",
                "thresholdsGrid": [
                  {
                    "operator": "==",
                    "thresholdValue": "Oui",
                    "representation": "success",
                    "text": "{0}{1}"
                  },
                  {
                    "operator": "Default",
                    "thresholdValue": null,
                    "representation": "4",
                    "text": "{0}{1}"
                  }
                ]
              }
            },
            {
              "columnMatch": "id",
              "formatter": 5
            }
          ],
          "filter": true,
          "hierarchySettings": {
            "treeType": 1,
            "groupBy": [
              "subscriptionId"
            ],
            "expandTopLevel": true
          },
          "sortBy": [
            {
              "itemKey": "$gen_thresholds_FluxdeMmodification_15",
              "sortOrder": 1
            }
          ]
        },
        "sortBy": [
          {
            "itemKey": "$gen_thresholds_FluxdeMmodification_15",
            "sortOrder": 1
          }
        ]
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "requête - Liste des storage account blob backupés"
    },
    {
      "type": 1,
      "content": {
        "json": "\r\n\r\n\r\n"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "texte - 5 - Saut ligne"
    },
    {
      "type": 1,
      "content": {
        "json": "\r\n\r\n\r\n"
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "texte - 5 - Saut ligne"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "{\"version\":\"Merge/1.0\",\"merges\":[{\"id\":\"1a538287-10b7-4421-b00c-221c5d9a744f\",\"mergeType\":\"leftanti\",\"leftTable\":\"query - Liste basique Storage Account\",\"rightTable\":\"requête - Liste des instances par Vault\",\"leftColumn\":\"name\",\"rightColumn\":\"ResourceName\"}],\"projectRename\":[{\"originalName\":\"[query - Liste basique Storage Account].subscriptionId\",\"mergedName\":\"subscriptionId\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a744f\"},{\"originalName\":\"[query - Liste basique Storage Account].id\",\"mergedName\":\"id\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a744f\"},{\"originalName\":\"[query - Liste basique Storage Account].name\",\"mergedName\":\"name\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a744f\"},{\"originalName\":\"[Colonne ajoutée]\",\"mergedName\":\"Protection\",\"fromId\":null,\"isNewItem\":true,\"newItemData\":[{\"criteriaContext\":{\"operator\":\"Default\",\"rightValType\":\"column\",\"resultValType\":\"static\",\"resultVal\":\"NotConfigured\"}}]},{\"originalName\":\"[query - Liste basique Storage Account].kind\",\"mergedName\":\"kind\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a744f\"},{\"originalName\":\"[query - Liste basique Storage Account].Redondance\",\"mergedName\":\"Redondance\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a744f\"},{\"originalName\":\"[query - Liste basique Storage Account].Type_Acces\",\"mergedName\":\"Type_Acces\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a744f\"},{\"originalName\":\"[query - Liste basique Storage Account].PrimaryLocation\",\"mergedName\":\"PrimaryLocation\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a744f\"},{\"originalName\":\"[query - Liste basique Storage Account].statusOfPrimary\",\"mergedName\":\"statusOfPrimary\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a744f\"},{\"originalName\":\"[query - Liste basique Storage Account].SecondaryLocation\",\"mergedName\":\"SecondaryLocation\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a744f\"},{\"originalName\":\"[query - Liste basique Storage Account].statusOfSecondary\",\"mergedName\":\"statusOfSecondary\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a744f\"},{\"originalName\":\"[query - Liste basique Storage Account].resourceGroup\",\"mergedName\":\"resourceGroup\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a744f\"},{\"originalName\":\"[query - Liste basique Storage Account].sku_name\",\"mergedName\":\"sku_name\",\"fromId\":\"1a538287-10b7-4421-b00c-221c5d9a744f\"},{\"originalName\":\"[query - Liste basique Storage Account].subscriptionName\",\"mergedName\":\"subscriptionName\",\"fromId\":\"unknown\"},{\"originalName\":\"[query - Liste basique Storage Account].Tags\"},{\"originalName\":\"[query - Liste basique Storage Account].Details\"}]}",
        "size": 0,
        "title": "Liste des Storage Account Non backupés",
        "showRefreshButton": true,
        "showExportToExcel": true,
        "queryType": 7,
        "gridSettings": {
          "formatters": [
            {
              "columnMatch": "$gen_group",
              "formatter": 13,
              "formatOptions": {
                "linkTarget": null,
                "showIcon": true
              }
            },
            {
              "columnMatch": "subscriptionId",
              "formatter": 5
            },
            {
              "columnMatch": "Protection",
              "formatter": 18,
              "formatOptions": {
                "thresholdsOptions": "icons",
                "thresholdsGrid": [
                  {
                    "operator": "==",
                    "thresholdValue": "NotConfigured",
                    "representation": "4",
                    "text": "{0}{1}"
                  },
                  {
                    "operator": "Default",
                    "thresholdValue": null,
                    "representation": "success",
                    "text": "{0}{1}"
                  }
                ]
              }
            }
          ],
          "filter": true,
          "hierarchySettings": {
            "treeType": 1,
            "groupBy": [
              "subscriptionId"
            ],
            "expandTopLevel": true
          }
        }
      },
      "conditionalVisibility": {
        "parameterName": "selectedTab",
        "comparison": "isEqualTo",
        "value": "backups"
      },
      "name": "requête - Liste des Storage Account Non backupés"
    }
  ],
  "fallbackResourceIds": [
    "azure monitor"
  ],
  "$schema": "https://github.com/Microsoft/Application-Insights-Workbooks/blob/master/schema/workbook.json"
})
tags = local.common_tags
}