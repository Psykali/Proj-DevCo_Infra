###########################################
## Create Resource Group
##resource "azurerm_resource_group" "rg" {
##  name     = var.resource_group_name
##  location = var.location
##}
###########################################
## Create Storage Acc
resource "azurerm_storage_account" "sppersotfstates" {
  name = var.storage_account_name
  resource_group_name = var.resource_group_name
  location = var.location
  account_tier = "Standard"
  account_replication_type = "LRS"

  tags = {
    Env = "Prod"
    Why = "DiplomeP20"
    CreatedBy = "SK"
  }
}
##
## Create Container
resource "azurerm_storage_container" "hello_container" {
  name                  = "hello_container"
  storage_account_name  = azurerm_storage_account.sppersotfstates.name

tags = {
    Env = "Prod"
    Why = "DiplomeP20"
    CreatedBy = "SK"
  }
}
##
## Create Blobs
resource "azurerm_storage_blob" "hello_blob" {
  name = var.blob_container_name
  storage_account_name = var.storage_account_name
  container_name = azurerm_storage_container.hello_container.name
  type                   = "Block"
  source_content         = "Hello, world!"
}
##
## Create KeyVault
resource "azurerm_key_vault" "sppersosecrets" {
  name = var.key_vault_name
  resource_group_name = var.resource_group_name
  location = var.location
  sku_name            = "standard"
  tenant_id           = data.azurerm_client_config.current.tenant_id

tags = {
    Env = "Prod"
    Why = "DiplomeP20"
    CreatedBy = "SK"
  }
}
##
## Create Secrets
resource "azurerm_key_vault_secret" "hello_secret" {
  name = "hello_secret"
  value = "hello world"
  key_vault_id = "${azurerm_key_vault.sppersosecrets.id}"
tags = {
    Env = "Prod"
    Why = "DiplomeP20"
    CreatedBy = "SK"
  }
}