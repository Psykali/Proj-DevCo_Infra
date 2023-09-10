###########################
## Create Resource Group
##########################
##resource "azurerm_resource_group" "rg" {
##  name     = var.resource_group_name
##  location = var.location
##}
##########
## Tags ##
##########
locals {
  common_tags = {
    CreatedBy = "SK"
    Env       = "Prod"
    Why       = "DipP20"
    Proj        = "Jenkins_AKS"
    Infratype   = "PaaS-IaaS-IaC"
    Ressources  = "VM-NSG-VNET-AKS-ContReg-Workbook-DockerHub-DockerImg"
  }
}