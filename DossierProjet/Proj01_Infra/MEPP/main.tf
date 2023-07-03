provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "PERSO_SIEF"
  location = "francecentral"
}

resource "azurerm_virtual_network" "vnet" {
  name                = "skVNET"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "subnet" {
  name                 = "skSubnet"
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_network_interface" "nic" {
  count               = 2
  name                = "skNIC${count.index + 1}"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = "skVM"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  size                = "Standard_B1s"

  network_interface_ids = [
    azurerm_network_interface.nic[0].id,
    azurerm_network_interface.nic[1].id,
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  admin_username = "skadminadmin"
  admin_password = "skpassadminpass"
}

resource "azurerm_mariadb_server" "mariadb" {
  name                = "skMariaDB"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  administrator_login          = "skadminadmin"
  administrator_login_password = "skpassadminpass"

  sku_name     = "B_Gen5_2"
  storage_mb   = 5120
  version      = "10.3"
  ssl_enforcement_enabled = false
}

resource "azurerm_app_service_plan" "asp" {
  name                = "skASP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  sku {
    tier     = "Standard"
    size     = "S1"
    capacity = 2
  }
}

resource "azurerm_app_service" "webapp1" {
  name                = "skWebApp1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    always_on                = true
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}

resource "azurerm_app_service" "webapp2" {
  name                = "skWebApp2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  app_service_plan_id = azurerm_app_service_plan.asp.id

  site_config {
    always_on                = true
    dotnet_framework_version = "v4.0"
    scm_type                 = "LocalGit"
  }
}

resource "azurerm_storage_account" "storageaccount" {
  name                     = "skstorageaccount${random_string.random_string.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "GRS"
}

resource "random_string" "random_string" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_application_insights" "appinsights1" {
  name                = "skAppInsights1"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

resource "azurerm_application_insights" "appinsights2" {
  name                = "skAppInsights2"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  application_type    = "web"
}

resource "azurerm_public_ip" "publicip" {
  name                = "skPublicIP"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_lb_backend_address_pool" "backendpool" {
  name                = "BackEndAddressPool"
  resource_group_name = azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_loadbalancer.loadbalancer.id
}

resource "azurerm_lb_probe" "probe" {
  name                = "httpProbe"
  resource_group_name = azurerm_resource_group.rg.name
  loadbalancer_id     = azurerm_loadbalancer.loadbalancer.id
  port                = 80
  protocol            = "Http"
  request_path        = "/"
}

resource "azurerm_lb_rule" "rule" {
  name                         = "httpRule"
  resource_group_name          = azurerm_resource_group.rg.name
  loadbalancer_id              = azurerm_loadbalancer.loadbalancer.id
  protocol                     = "Tcp"
  frontend_port                = 80
  backend_port                 = 80
  frontend_ip_configuration_name = azurerm_loadbalancer.loadbalancer.frontend_ip_configuration[0].name
  backend_address_pool_id      = azurerm_lb_backend_address_pool.backendpool.id
  probe_id                     = azurerm_lb_probe.probe.id
}

resource "azurerm_loadbalancer" "loadbalancer" {
  name                = "skLoadBalancer"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name

  frontend_ip_configuration {
    name                 = "LoadBalancerFrontEnd"
    public_ip_address_id = azurerm_public_ip.publicip.id
  }
}

resource "azurerm_network_interface_backend_address_pool_association" "association1" {
  network_interface_id         = azurerm_network_interface.nic1.id
  ip_configuration_name        = "internal"
  backend_address_pool_id      = azurerm_lb_backend_address_pool.backendpool.id
}

resource "azurerm_network_interface_backend_address_pool_association" "association2" {
  network_interface_id         = azurerm_network_interface.nic2.id
  ip_configuration_name        = "internal"
  backend_address_pool_id      = azurerm_lb_backend_address_pool.backendpool.id
}