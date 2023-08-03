#########################
## Create WebServer VM ##
#########################
resource "azurerm_linux_virtual_machine" "web_vm" {
  name                = var.web_vm
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = "Standard_B2ms"
  disable_password_authentication= false

network_interface_ids= [
    azurerm_network_interface.web_nic.id,
]

os_disk {
    caching              = "ReadWrite"
    storage_account_type= "Standard_LRS"
}

source_image_reference {
    publisher= "Canonical"
    offer    = "UbuntuServer"
    sku      = "20.04-LTS"
    version= "latest"
}

  admin_username= var.admin_username
  admin_password= var.admin_password

  tags = local.common_tags
}
##############################
## Create Network Interface ##
##############################
resource "azurerm_network_interface" "web_nic" {
  name = var.web_nic
  location = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = var.web_ip
    subnet_id                     = azurerm_subnet.default.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.web_pip.id
  }
  tags = local.common_tags
}
################################
## Create a public IP address ##
################################
resource "azurerm_public_ip" "web_pip" {
  name                = var.web_pip
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Dynamic"
  domain_name_label   = var.web_vm
  tags = local.common_tags
}
###################
## SQL Databases ##
###################
resource "azurerm_mysql_database" "web_db" {
  name                = "webdb"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.mysql.name
  charset             = "UTF8"
  collation           = "UTF8_GENERAL_CI"
}
#######################################################################
####################
## Bash Scripting ##
####################
# Deploy Git Server
resource "null_resource" "install_packages" {
   depends_on = [
    azurerm_linux_virtual_machine.web_vm,
    azurerm_mysql_database.web_db,
  ]

  connection {
    type     = "ssh"
    user     = var.admin_username
    password = var.admin_password
    host     = azurerm_linux_virtual_machine.gitlab_vm.public_ip_address
  }

provisioner "remote-exec" {
  inline = [
        "sudo apt-get update && sudo apt-get -y upgrade",
        "sudo apt-get install -y apache2",
        "sudo apt-get install -y mariadb-server",
        "sudo apt-get install -y php libapache2-mod-php php-mysql",
        "wget -c http://wordpress.org/latest.tar.gz",
        "tar -xzvf latest.tar.gz",
        "sudo rsync -av wordpress/* /var/www/html/",
        "sudo chown -R www-data:www-data /var/www/html/",
        "sudo chmod -R 755 /var/www/html/",
  ]
}
}