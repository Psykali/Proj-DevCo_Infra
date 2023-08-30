#####################
## Create App Plan ##
#####################
resource "azurerm_app_service_plan" "example" {
  name                = "app-service-plan"
  location            = "France Central"
  resource_group_name = "PERSO_SIEF"
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Basic"
    size = "B1"
  }
}
##################################
## Create Web App for WordPress ##
##################################
variable "app_names" {
  type = list(string)
  default = ["1stTetris", "2ndTetris", "3rdTetris"]
}
resource "azurerm_app_service" "wordpress" {
  count               = length(var.app_names)
  name                = var.app_names[count.index]
  location            = var.location
  resource_group_name = var.resource_group_name
  app_service_plan_id = azurerm_app_service_plan.example.id

  site_config {
    always_on = true
    linux_fx_version = "DOCKER|skP20ContReg.azurecr.io/tetrisgameapp"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = local.common_tags
}

resource "azurerm_app_service_slot" "example" {
  app_service_name       = azurerm_app_service.wordpress[0].name
  location               = azurerm_app_service.wordpress[0].location
  resource_group_name    = azurerm_app_service.wordpress[0].resource_group_name
  app_service_plan_id    = azurerm_app_service_plan.example.id
  name                   = "staging"

  connection_string {
    name  = "Database"
    type  = "SQLAzure"
    value = "Server=tcp:${azurerm_lb.sqldbbkndlb.private_ip_address},1433;Initial Catalog=sqldb-0;User ID=${var.admin_username};Password=${var.admin_password};"
  }
}
################################################
## Create Public IP address for Load Balancer ##
################################################
resource "azurerm_public_ip" "lb_pip" {
  name                = "Tetrislb-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = local.common_tags
}
##################################
## Create Load Balancer WebApps ##
##################################
resource "azurerm_lb" "lb" {
  name                = "Tetris-lb"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"

  frontend_ip_configuration {
    name                 = "TetrisPIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
  tags = local.common_tags
}
#######################################
## backend pool of the load balancer ##
#######################################
resource "azurerm_lb_backend_address_pool" "example" {
  loadbalancer_id = azurerm_lb.lb.id
  name            = "BackendPool"
}
###############################################################
## Add the Web Apps to the backend pool of the load balancer ##
###############################################################
resource "azurerm_lb_backend_address_pool_address" "example" {
  backend_address_pool_id = azurerm_lb_backend_address_pool.example.id
  name                    = "Tetrisbkndpl"
  ip_address              = azurerm_linux_virtual_machine.example.private_ip_address # Update this argument
}
#######################
## Create Front Door ##
#######################
resource "azurerm_frontdoor" "frontdoor" {
  name                = "Tetris-frontdoor"
  location            = var.location
  resource_group_name = var.resource_group_name

  routing_rule {
    name               = "Tetris-routing-rule"
    frontend_endpoints = [azurerm_frontdoor_frontend_endpoint.frontend.id]
    accepted_protocols = ["Http", "Https"]
    patterns_to_match  = ["/*"]
    forwarding_configuration {
      backend_pool_name = azurerm_lb_backend_address_pool.backend_pool.name
      backend_protocol  = "Http"
      backend_host_header = azurerm_app_service.wordpress_primary.default_site_hostname
    }
  }

  frontend_endpoint {
    name                 = "Tetris-frontend"
    host_name            = azurerm_public_ip.lb_pip.fqdn
    session_affinity_enabled = true
    session_affinity_ttl_seconds = 300
  }

  tags = local.common_tags
}