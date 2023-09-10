###################################
## Deploy MàJ Reporting WorkBook ##
###################################
resource "azurerm_application_insights_workbook" "patch_reporting" {
  name                = "ce314efa-fe06-402d-b98b-294a8d90a034"
  location            = var.location
  resource_group_name = var.resource_group_name
  display_name        = "VM_MAJ_Reporting"
  data_json = jsonencode({
  "version": "Notebook/1.0",
  "items": [
    {
      "type": 1,
      "content": {
        "json": ""
      },
      "customWidth": "100",
      "name": "text - 5"
    },
    {
      "type": 9,
      "content": {
        "version": "KqlParameterItem/1.0",
        "parameters": [
          {
            "id": "f8d6705a-e284-4077-8113-aae1038a6b7c",
            "version": "KqlParameterItem/1.0",
            "name": "Workspaces",
            "type": 5,
            "isRequired": true,
            "multiSelect": true,
            "quote": "'",
            "delimiter": ",",
            "query": "where type =~ 'microsoft.operationalinsights/workspaces'\r\n| summarize by id, name",
            "crossComponentResources": [
              "value::all"
            ],
            "value": [
              "value::all"
            ],
            "typeSettings": {
              "additionalResourceOptions": [
                "value::1",
                "value::all"
              ]
            },
            "queryType": 1,
            "resourceType": "microsoft.resourcegraph/resources"
          },
          {
            "id": "0b10a460-6c43-4ba3-a783-53950f998997",
            "version": "KqlParameterItem/1.0",
            "name": "TimeRange",
            "type": 4,
            "isRequired": true,
            "typeSettings": {
              "selectableValues": [
                {
                  "durationMs": 300000
                },
                {
                  "durationMs": 900000
                },
                {
                  "durationMs": 1800000
                },
                {
                  "durationMs": 3600000
                },
                {
                  "durationMs": 14400000
                },
                {
                  "durationMs": 43200000
                },
                {
                  "durationMs": 86400000
                },
                {
                  "durationMs": 172800000
                },
                {
                  "durationMs": 259200000
                },
                {
                  "durationMs": 604800000
                },
                {
                  "durationMs": 1209600000
                },
                {
                  "durationMs": 2419200000
                },
                {
                  "durationMs": 2592000000
                },
                {
                  "durationMs": 5184000000
                },
                {
                  "durationMs": 7776000000
                }
              ],
              "allowCustom": true
            },
            "value": {
              "durationMs": 3600000
            }
          },
          {
            "id": "dd314b91-9aee-492c-9ae7-4800ecdaf05b",
            "version": "KqlParameterItem/1.0",
            "name": "Ressource",
            "type": 5,
            "multiSelect": true,
            "quote": "'",
            "delimiter": ",",
            "typeSettings": {
              "additionalResourceOptions": [
                "value::all"
              ]
            }
          }
        ],
        "style": "pills",
        "queryType": 0,
        "resourceType": "microsoft.operationalinsights/workspaces"
      },
      "name": "parameters - 11"
    },
    {
      "type": 1,
      "content": {
        "json": "# Azure Automation Windows Update Summary for All Subscriptions\r\n\r\nThis workbook can query multiple Log Analytics Workspaces. The Azure Automation Update Management solution needs to be linked to every Log Analytics Workspaces you wish to use it with."
      },
      "name": "text - 6"
    },
    {
      "type": 1,
      "content": {
        "json": "## Updates Installed \r\n\r\n"
      },
      "name": "text - 9"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "Update\r\n| where TimeGenerated>ago(14h) and OSType!=\"Linux\" and (Optional==false or Classification has \"Critical\" or Classification has \"Security\") and SourceComputerId in ((Heartbeat\r\n| where TimeGenerated>ago(12h) and OSType=~\"Windows\" and notempty(Computer)\r\n| summarize arg_max(TimeGenerated, Solutions) by SourceComputerId\r\n| where Solutions has \"updates\" | distinct SourceComputerId))\r\n| summarize hint.strategy=partitioned arg_max(TimeGenerated, *) by Computer, SourceComputerId, UpdateID\r\n| where UpdateState=~\"Installed\" and Approved!=false\r\n| summarize UpdatesNeeded=count(Classification) by Classification",
        "size": 2,
        "title": "Windows Updates Installed by Classification",
        "queryType": 0,
        "resourceType": "microsoft.operationalinsights/workspaces",
        "crossComponentResources": [
          "{Workspaces}"
        ],
        "visualization": "piechart",
        "tileSettings": {
          "showBorder": false,
          "titleContent": {
            "columnMatch": "Classification",
            "formatter": 1
          },
          "leftContent": {
            "columnMatch": "UpdatesNeeded",
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
        "chartSettings": {
          "seriesLabelSettings": [
            {
              "seriesName": "Definition Updates",
              "color": "yellow"
            },
            {
              "seriesName": "Updates",
              "color": "orange"
            },
            {
              "seriesName": "Security Updates",
              "color": "redBright"
            },
            {
              "seriesName": "Update Rollups",
              "color": "purple"
            },
            {
              "seriesName": "Critical Updates",
              "color": "red"
            }
          ]
        }
      },
      "customWidth": "50",
      "name": "Installed update graph"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "Update\r\n| where TimeGenerated>ago(14h) and OSType!=\"Linux\" and (Optional==false or Classification has \"Critical\" or Classification has \"Security\") and SourceComputerId in ((Heartbeat\r\n| where TimeGenerated>ago(12h) and OSType=~\"Windows\" and notempty(Computer)\r\n| summarize arg_max(TimeGenerated, Solutions) by SourceComputerId\r\n| where Solutions has \"updates\" | distinct SourceComputerId))\r\n| summarize hint.strategy=partitioned arg_max(TimeGenerated, *) by Computer, SourceComputerId, UpdateID\r\n| where UpdateState=~\"Installed\" and Approved!=false\r\n| project Computer, Title, Classification, PublishedDate, UpdateState, Product\r\n| summarize count(Classification) by Computer \r\n| top 5 by count_Classification desc ",
        "size": 2,
        "title": "Top 5 Windows Machines by Installed Update Count",
        "queryType": 0,
        "resourceType": "microsoft.operationalinsights/workspaces",
        "crossComponentResources": [
          "{Workspaces}"
        ],
        "visualization": "piechart"
      },
      "customWidth": "50",
      "name": "top five Computers Needing Updates - Copy"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "Heartbeat\r\n| where TimeGenerated>ago(12h) and OSType=~\"Windows\" and notempty(Computer)\r\n| summarize arg_max(TimeGenerated, Solutions, Computer, ResourceId, ComputerEnvironment, VMUUID) by SourceComputerId\r\n| where Solutions has \"updates\"\r\n| extend vmuuId=VMUUID, azureResourceId=ResourceId, osType=2, environment=iff(ComputerEnvironment=~\"Azure\", 1, 2), scopedToUpdatesSolution=true//, lastUpdateAgentSeenTime=\"\"\r\n| join kind=leftouter\r\n(\r\n    Update\r\n    | where TimeGenerated>ago(14h) and OSType!=\"Linux\" and SourceComputerId in ((Heartbeat\r\n    | where TimeGenerated>ago(12h) and OSType=~\"Windows\" and notempty(Computer)\r\n    | summarize arg_max(TimeGenerated, Solutions) by SourceComputerId\r\n    | where Solutions has \"updates\"\r\n    | distinct SourceComputerId))\r\n    | summarize hint.strategy=partitioned arg_max(TimeGenerated, UpdateState, Classification, Title, Optional, Approved, Computer, ComputerEnvironment) by Computer, SourceComputerId, UpdateID\r\n    | summarize Computer=any(Computer), ComputerEnvironment=any(ComputerEnvironment), missingCriticalUpdatesCount=countif(Classification has \"Critical\" and UpdateState=~\"Installed\" and Approved!=false), missingSecurityUpdatesCount=countif(Classification has \"Security\" and UpdateState=~\"Installed\" and Approved!=false), missingOtherUpdatesCount=countif(Classification !has \"Critical\" and Classification !has \"Security\" and UpdateState=~\"Installed\" and Optional==false and Approved!=false), lastAssessedTime=max(TimeGenerated), LastUpdateTime=max(TimeGenerated) by SourceComputerId\r\n    | extend compliance=iff(missingCriticalUpdatesCount > 0 or missingSecurityUpdatesCount > 0, 2, 1)\r\n    | extend ComplianceOrder=iff(missingCriticalUpdatesCount > 0 or missingSecurityUpdatesCount > 0 or missingOtherUpdatesCount > 0, 1, 3)\r\n)\r\non SourceComputerId\r\n| project id=SourceComputerId, displayName=Computer, sourceComputerId=SourceComputerId, scopedToUpdatesSolution=true, missingCriticalUpdatesCount=coalesce(missingCriticalUpdatesCount, -1), missingSecurityUpdatesCount=coalesce(missingSecurityUpdatesCount, -1), missingOtherUpdatesCount=coalesce(missingOtherUpdatesCount, -1), compliance=coalesce(compliance, 4), lastAssessedTime, LastUpdateTime, osType=2, environment=iff(ComputerEnvironment=~\"Azure\", 1, 2), ComplianceOrder=coalesce(ComplianceOrder, 2) \r\n| order by ComplianceOrder asc, missingCriticalUpdatesCount desc, missingSecurityUpdatesCount desc, missingOtherUpdatesCount desc, displayName asc\r\n| project displayName, scopedToUpdatesSolution, CriticalUpdates=missingCriticalUpdatesCount, SecurityUpdates=missingSecurityUpdatesCount, OtherUpdates=missingOtherUpdatesCount, compliance, osType, Environment=environment, lastAssessedTime, LastUpdateTime\r\n| extend osType = replace(@\"2\", @\"Windows\", tostring(osType))\r\n| extend osType = replace(@\"1\", @\"Linux\", tostring(osType))\r\n| extend Environment = replace(@\"2\", @\"Non-Azure\", tostring(Environment))\r\n| extend Environment = replace(@\"1\", @\"Azure\", tostring(Environment))\r\n",
        "size": 0,
        "title": "Update Installed By Server",
        "exportFieldName": "displayName",
        "exportParameterName": "Computer",
        "showExportToExcel": true,
        "queryType": 0,
        "resourceType": "microsoft.operationalinsights/workspaces",
        "crossComponentResources": [
          "{Workspaces}"
        ],
        "visualization": "table",
        "gridSettings": {
          "formatters": [
            {
              "columnMatch": "scopedToUpdatesSolution",
              "formatter": 5
            },
            {
              "columnMatch": "CriticalUpdates",
              "formatter": 8,
              "formatOptions": {
                "min": 0,
                "max": 1,
                "palette": "green"
              }
            },
            {
              "columnMatch": "SecurityUpdates",
              "formatter": 8,
              "formatOptions": {
                "min": 0,
                "max": 5,
                "palette": "green"
              }
            },
            {
              "columnMatch": "OtherUpdates",
              "formatter": 8,
              "formatOptions": {
                "min": 0,
                "max": 5,
                "palette": "green"
              }
            },
            {
              "columnMatch": "compliance",
              "formatter": 8,
              "formatOptions": {
                "min": 1,
                "max": 2,
                "palette": "green"
              }
            },
            {
              "columnMatch": "lastAssessedTime",
              "formatter": 5
            }
          ],
          "filter": true
        },
        "sortBy": []
      },
      "name": "Update Installed"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "Update\r\n| where TimeGenerated>ago(14h) and OSType!=\"Linux\" and (Optional==false or Classification has \"Critical\" or Classification has \"Security\") and SourceComputerId in ((Heartbeat\r\n| where TimeGenerated>ago(12h) and OSType=~\"Windows\" and notempty(Computer)\r\n| summarize arg_max(TimeGenerated, Solutions) by SourceComputerId\r\n| where Solutions has \"updates\" | distinct SourceComputerId))\r\n| summarize hint.strategy=partitioned arg_max(TimeGenerated, *) by Computer, SourceComputerId, UpdateID\r\n| where UpdateState=~\"Installed\" and Approved!=false \r\n| project VM = Computer, Title, Classification, LastUpdateTime = PublishedDate, UpdateState, Product",
        "size": 0,
        "title": "Installed Update By Title",
        "showExportToExcel": true,
        "queryType": 0,
        "resourceType": "microsoft.operationalinsights/workspaces",
        "crossComponentResources": [
          "{Workspaces}"
        ],
        "gridSettings": {
          "formatters": [
            {
              "columnMatch": "Classification",
              "formatter": 18,
              "formatOptions": {
                "thresholdsOptions": "colors",
                "thresholdsGrid": [
                  {
                    "operator": "==",
                    "thresholdValue": "Updates",
                    "representation": "orange",
                    "text": "{0}{1}"
                  },
                  {
                    "operator": "==",
                    "thresholdValue": "Security Updates",
                    "representation": "redBright",
                    "text": "{0}{1}"
                  },
                  {
                    "operator": "==",
                    "thresholdValue": "Definition Updates",
                    "representation": "yellow",
                    "text": "{0}{1}"
                  },
                  {
                    "operator": "==",
                    "thresholdValue": "Update Rollups",
                    "representation": "purple",
                    "text": "{0}{1}"
                  },
                  {
                    "operator": "==",
                    "thresholdValue": "Critical Updates",
                    "representation": "red",
                    "text": "{0}{1}"
                  },
                  {
                    "operator": "Default",
                    "thresholdValue": null,
                    "representation": "blue",
                    "text": "{0}{1}"
                  }
                ]
              }
            },
            {
              "columnMatch": "Product",
              "formatter": 5
            }
          ],
          "filter": true
        }
      },
      "name": "Update installed List"
    },
    {
      "type": 1,
      "content": {
        "json": "## Updates Needed "
      },
      "name": "text - 10"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "Update\r\n| where TimeGenerated>ago(14h) and OSType!=\"Linux\" and (Optional==false or Classification has \"Critical\" or Classification has \"Security\") and SourceComputerId in ((Heartbeat\r\n| where TimeGenerated>ago(12h) and OSType=~\"Windows\" and notempty(Computer)\r\n| summarize arg_max(TimeGenerated, Solutions) by SourceComputerId\r\n| where Solutions has \"updates\" | distinct SourceComputerId))\r\n| summarize hint.strategy=partitioned arg_max(TimeGenerated, *) by Computer, SourceComputerId, UpdateID\r\n| where UpdateState=~\"Needed\" and Approved!=false\r\n| summarize UpdatesNeeded=count(Classification) by Classification",
        "size": 2,
        "title": "Windows Updates need by Classification",
        "queryType": 0,
        "resourceType": "microsoft.operationalinsights/workspaces",
        "crossComponentResources": [
          "{Workspaces}"
        ],
        "visualization": "piechart",
        "tileSettings": {
          "showBorder": false,
          "titleContent": {
            "columnMatch": "Classification",
            "formatter": 1
          },
          "leftContent": {
            "columnMatch": "UpdatesNeeded",
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
        "chartSettings": {
          "seriesLabelSettings": [
            {
              "seriesName": "Definition Updates",
              "color": "yellow"
            },
            {
              "seriesName": "Updates",
              "color": "orange"
            },
            {
              "seriesName": "Security Updates",
              "color": "redBright"
            },
            {
              "seriesName": "Update Rollups",
              "color": "purple"
            },
            {
              "seriesName": "Critical Updates",
              "color": "red"
            }
          ]
        }
      },
      "customWidth": "50",
      "name": "Windows Updates need by Classification"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "Update\r\n| where TimeGenerated>ago(14h) and OSType!=\"Linux\" and (Optional==false or Classification has \"Critical\" or Classification has \"Security\") and SourceComputerId in ((Heartbeat\r\n| where TimeGenerated>ago(12h) and OSType=~\"Windows\" and notempty(Computer)\r\n| summarize arg_max(TimeGenerated, Solutions) by SourceComputerId\r\n| where Solutions has \"updates\" | distinct SourceComputerId))\r\n| summarize hint.strategy=partitioned arg_max(TimeGenerated, *) by Computer, SourceComputerId, UpdateID\r\n| where UpdateState=~\"Needed\" and Approved!=false\r\n| project Computer, Title, Classification, PublishedDate, UpdateState, Product\r\n| summarize count(Classification) by Computer \r\n| top 5 by count_Classification desc ",
        "size": 2,
        "title": "Top 5 Windows Machines by Update Count",
        "queryType": 0,
        "resourceType": "microsoft.operationalinsights/workspaces",
        "crossComponentResources": [
          "{Workspaces}"
        ],
        "visualization": "piechart"
      },
      "customWidth": "50",
      "name": "top five Computers Needing Updates"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "Heartbeat\r\n| where TimeGenerated>ago(12h) and OSType=~\"Windows\" and notempty(Computer)\r\n| summarize arg_max(TimeGenerated, Solutions, Computer, ResourceId, ComputerEnvironment, VMUUID) by SourceComputerId\r\n| where Solutions has \"updates\"\r\n| extend vmuuId=VMUUID, azureResourceId=ResourceId, osType=2, environment=iff(ComputerEnvironment=~\"Azure\", 1, 2), scopedToUpdatesSolution=true, lastUpdateAgentSeenTime=\"\"\r\n| join kind=leftouter\r\n(\r\n    Update\r\n    | where TimeGenerated>ago(14h) and OSType!=\"Linux\" and SourceComputerId in ((Heartbeat\r\n    | where TimeGenerated>ago(12h) and OSType=~\"Windows\" and notempty(Computer)\r\n    | summarize arg_max(TimeGenerated, Solutions) by SourceComputerId\r\n    | where Solutions has \"updates\"\r\n    | distinct SourceComputerId))\r\n    | summarize hint.strategy=partitioned arg_max(TimeGenerated, UpdateState, Classification, Title, Optional, Approved, Computer, ComputerEnvironment) by Computer, SourceComputerId, UpdateID\r\n    | summarize Computer=any(Computer), ComputerEnvironment=any(ComputerEnvironment), missingCriticalUpdatesCount=countif(Classification has \"Critical\" and UpdateState=~\"Needed\" and Approved!=false), missingSecurityUpdatesCount=countif(Classification has \"Security\" and UpdateState=~\"Needed\" and Approved!=false), missingOtherUpdatesCount=countif(Classification !has \"Critical\" and Classification !has \"Security\" and UpdateState=~\"Needed\" and Optional==false and Approved!=false), PublishedTime=max(TimeGenerated), lastUpdateAgentSeenTime=\"\" by SourceComputerId\r\n    | extend compliance=iff(missingCriticalUpdatesCount > 0 or missingSecurityUpdatesCount > 0, 2, 1)\r\n    | extend ComplianceOrder=iff(missingCriticalUpdatesCount > 0 or missingSecurityUpdatesCount > 0 or missingOtherUpdatesCount > 0, 1, 3)\r\n)\r\non SourceComputerId\r\n| project id=SourceComputerId, displayName=Computer, sourceComputerId=SourceComputerId, scopedToUpdatesSolution=true, missingCriticalUpdatesCount=coalesce(missingCriticalUpdatesCount, -1), missingSecurityUpdatesCount=coalesce(missingSecurityUpdatesCount, -1), missingOtherUpdatesCount=coalesce(missingOtherUpdatesCount, -1), compliance=coalesce(compliance, 4), PublishedTime, lastUpdateAgentSeenTime, osType=2, environment=iff(ComputerEnvironment=~\"Azure\", 1, 2), ComplianceOrder=coalesce(ComplianceOrder, 2) \r\n| order by ComplianceOrder asc, missingCriticalUpdatesCount desc, missingSecurityUpdatesCount desc, missingOtherUpdatesCount desc, displayName asc\r\n| project displayName, scopedToUpdatesSolution, CriticalUpdates=missingCriticalUpdatesCount, SecurityUpdates=missingSecurityUpdatesCount, OtherUpdates=missingOtherUpdatesCount, compliance, osType, Environment=environment, PublishedTime, lastUpdateAgentSeenTime\r\n| extend osType = replace(@\"2\", @\"Windows\", tostring(osType))\r\n| extend osType = replace(@\"1\", @\"Linux\", tostring(osType))\r\n| extend Environment = replace(@\"2\", @\"Non-Azure\", tostring(Environment))\r\n| extend Environment = replace(@\"1\", @\"Azure\", tostring(Environment))",
        "size": 0,
        "title": "Updates Needed By Server",
        "exportFieldName": "displayName",
        "exportParameterName": "Computer",
        "queryType": 0,
        "resourceType": "microsoft.operationalinsights/workspaces",
        "crossComponentResources": [
          "{Workspaces}"
        ],
        "visualization": "table",
        "gridSettings": {
          "formatters": [
            {
              "columnMatch": "scopedToUpdatesSolution",
              "formatter": 5
            },
            {
              "columnMatch": "CriticalUpdates",
              "formatter": 8,
              "formatOptions": {
                "min": 0,
                "max": 1,
                "palette": "greenRed"
              }
            },
            {
              "columnMatch": "SecurityUpdates",
              "formatter": 8,
              "formatOptions": {
                "min": 0,
                "max": 5,
                "palette": "greenRed"
              }
            },
            {
              "columnMatch": "OtherUpdates",
              "formatter": 8,
              "formatOptions": {
                "min": 0,
                "max": 5,
                "palette": "greenRed"
              }
            },
            {
              "columnMatch": "compliance",
              "formatter": 8,
              "formatOptions": {
                "min": 1,
                "max": 2,
                "palette": "greenRed"
              }
            },
            {
              "columnMatch": "lastUpdateAgentSeenTime",
              "formatter": 5
            }
          ],
          "filter": true
        },
        "sortBy": []
      },
      "name": "Update To DO "
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "Update\r\n| where TimeGenerated>ago(14h) and OSType!=\"Linux\" and (Optional==false or Classification has \"Critical\" or Classification has \"Security\") and SourceComputerId in ((Heartbeat\r\n| where TimeGenerated>ago(12h) and OSType=~\"Windows\" and notempty(Computer)\r\n| summarize arg_max(TimeGenerated, Solutions) by SourceComputerId\r\n| where Solutions has \"updates\" | distinct SourceComputerId))\r\n| summarize hint.strategy=partitioned arg_max(TimeGenerated, *) by Computer, SourceComputerId, UpdateID\r\n| where UpdateState=~\"Needed\" and Approved!=false \r\n| project Computer, Title, Classification, PublishedDate, UpdateState, Product",
        "size": 0,
        "title": "Updates Needed By Title",
        "queryType": 0,
        "resourceType": "microsoft.operationalinsights/workspaces",
        "crossComponentResources": [
          "{Workspaces}"
        ],
        "gridSettings": {
          "formatters": [
            {
              "columnMatch": "Classification",
              "formatter": 18,
              "formatOptions": {
                "showIcon": true,
                "thresholdsOptions": "colors",
                "thresholdsGrid": [
                  {
                    "operator": "==",
                    "thresholdValue": "Updates",
                    "representation": "orange",
                    "text": "{0}{1}"
                  },
                  {
                    "operator": "==",
                    "thresholdValue": "Security Updates",
                    "representation": "redBright",
                    "text": "{0}{1}"
                  },
                  {
                    "operator": "==",
                    "thresholdValue": "Definition Updates",
                    "representation": "yellow",
                    "text": "{0}{1}"
                  },
                  {
                    "operator": "==",
                    "thresholdValue": "Update Rollups",
                    "representation": "purple",
                    "text": "{0}{1}"
                  },
                  {
                    "operator": "==",
                    "thresholdValue": "Critical Updates",
                    "representation": "red",
                    "text": "{0}{1}"
                  },
                  {
                    "operator": "Default",
                    "thresholdValue": null,
                    "representation": "blue",
                    "text": "{0}{1}"
                  }
                ]
              }
            }
          ],
          "filter": true
        }
      },
      "name": "Updates liste"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "maintenanceresources\r\n| where type =~ \"microsoft.maintenance/maintenanceconfigurations/applyupdates\"\r\n| where properties.startDateTime > ago(30d)\r\n| where properties.maintenanceConfiguration.properties.maintenanceScope == \"InGuestPatch\"\r\n| project name, properties, id\r\n| extend joinId = tolower(properties.maintenanceConfigurationId)\r\n| join kind=leftouter (\r\n    resources\r\n    | where type =~ \"microsoft.maintenance/maintenanceconfigurations\"\r\n    | extend maintenanceConfigId = tolower(id)\r\n    | project maintenanceConfigId, tags\r\n) on $left.joinId == $right.maintenanceConfigId\r\n| extend status = tostring(properties.status)\r\n| extend maintenanceConfigurationName = tostring(properties.maintenanceConfiguration.name)\r\n| extend operationStartTime = todatetime(properties.startDateTime)\r\n| extend operationEndTime = iff(properties.status =~ \"InProgress\", datetime(null), todatetime(properties.endDateTime))\r\n| extend maintenanceConfigurationId = properties.maintenanceConfigurationId\r\n| extend scheduleRunId = properties.correlationId\r\n| extend succeededMachinesCount = properties.resourceUpdateSummary.succeeded\r\n| extend totalMachines = properties.resourceUpdateSummary.total\r\n| extend deepLink = strcat(\"https://portal.azure.com/#view/Microsoft_Azure_Automation/UpdateCenterMaintenanceRunHistoryBlade/maintenanceConfigurationId/\",\r\nstrcat_array(split(maintenanceConfigurationId,'/'), \"%2F\"), \"/maintenanceRunId/\", strcat_array(split(scheduleRunId,'/'), \"%2F\"),  \"/maintenanceRunName/\", name)\r\n| project-rename maintenanceRunId = name\r\n| project id, operationStartTime, status, tags, deepLink\r\n| order by operationStartTime desc",
        "size": 0,
        "title": "Historique par exécutions de maintenance",
        "showExportToExcel": true,
        "queryType": 1,
        "resourceType": "microsoft.resourcegraph/resources",
        "crossComponentResources": [
          "{Workspaces}"
        ],
        "gridSettings": {
          "formatters": [
            {
              "columnMatch": "id",
              "formatter": 1,
              "formatOptions": {
                "customColumnWidthSetting": "59.1429ch"
              }
            },
            {
              "columnMatch": "operationStartTime",
              "formatter": 6
            },
            {
              "columnMatch": "deepLink",
              "formatter": 1,
              "formatOptions": {
                "linkColumn": "deepLink",
                "linkTarget": "Url"
              }
            }
          ],
          "filter": true,
          "labelSettings": [
            {
              "columnId": "id",
              "label": "Exécution de maintenance"
            },
            {
              "columnId": "operationStartTime",
              "label": "Heure de début de l'opération"
            },
            {
              "columnId": "status",
              "label": "État"
            },
            {
              "columnId": "tags",
              "label": "Balise"
            },
            {
              "columnId": "deepLink",
              "label": "Afficher l’exécution de la maintenance"
            }
          ]
        }
      },
      "name": "historyByMaintenance"
    },
    {
      "type": 3,
      "content": {
        "version": "KqlItem/1.0",
        "query": "patchinstallationresources\r\n| where type =~ \"microsoft.compute/virtualmachines/patchinstallationresults\" or type =~ \"microsoft.hybridcompute/machines/patchinstallationresults\"\r\n| parse type with typeID \"/patchinstallationresults\"\r\n| parse id with * 'achines/' resourceName '/patchInstallationResults/' *\r\n| project resourceName, properties.status,properties.startDateTime, properties.lastModifiedDateTime, properties.startedBy,properties\r\n| union\r\n(patchassessmentresources\r\n| where type =~ \"microsoft.compute/virtualmachines/patchassessmentresults\" or type =~  \"microsoft.hybridcompute/machines/patchassessmentresults\"\r\n| parse type with typeID \"/patchinstallationresults\"\r\n| parse id with * 'achines/' resourceName '/patchAssessmentResults/' *\r\n| project resourceName, properties.status,properties.startDateTime, properties.lastModifiedDateTime, properties.startedBy ,properties)\r\n",
        "size": 0,
        "title": "Historique par machine",
        "showExportToExcel": true,
        "queryType": 1,
        "resourceType": "microsoft.resourcegraph/resources",
        "crossComponentResources": [
          "value::all"
        ],
        "gridSettings": {
          "formatters": [
            {
              "columnMatch": "properties_status",
              "formatter": 1
            },
            {
              "columnMatch": "properties_startDateTime",
              "formatter": 6
            },
            {
              "columnMatch": "properties_lastModifiedDateTime",
              "formatter": 6
            },
            {
              "columnMatch": "properties_startedBy",
              "formatter": 1
            },
            {
              "columnMatch": "tags",
              "formatter": 1
            }
          ],
          "filter": true,
          "labelSettings": [
            {
              "columnId": "resourceName",
              "label": "Nom"
            },
            {
              "columnId": "properties_status",
              "label": "État"
            },
            {
              "columnId": "properties_startDateTime",
              "label": "Heure de début"
            },
            {
              "columnId": "properties_lastModifiedDateTime",
              "label": "Heure de fin"
            },
            {
              "columnId": "properties_startedBy",
              "label": "Démarré par"
            },
            {
              "columnId": "properties",
              "label": "Voir les détails de l'exécution"
            }
          ]
        }
      },
      "name": "HistoryByRuns"
    }
  ],
  "fallbackResourceIds": [
    "azure monitor"
  ],
  "$schema": "https://github.com/Microsoft/Application-Insights-Workbooks/blob/master/schema/workbook.json"
})
tags = local.common_tags
}