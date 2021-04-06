terraform {
  backend "azurerm" {
    storage_account_name = "001terraformstatefile"
    container_name       = "state"
    key                  = "sbx.terraform.tfstate"
  }
}

provider "azurerm" {
  version = "=2.0.0"
  features {}
}

resource "azurerm_resource_group" "tfimportarticle" {
  name     = "tfimportarticle"
  location = "West Europe"
}

resource "azurerm_storage_account" "example" {
  name                     = "storageaccountname"
  resource_group_name      = azurerm_resource_group.tfimportarticle.name
  location                 = azurerm_resource_group.tfimportarticle.location
  account_tier             = "Standard"
  account_replication_type = "lrs"
  access_tier = "Cool"

  tags = {
    environment = "staging"
  }
}

resource "azurerm_api_management" "example_apim" {
  name                = "example-apim"
  resource_group_name      = azurerm_resource_group.tfimportarticle.name
  location                 = azurerm_resource_group.tfimportarticle.location
  publisher_name      = "My Company"
  publisher_email     = "company@terraform.io"

  sku_name = "Developer_1"

  policy {
    xml_content = <<XML
    <policies>
      <inbound />
      <backend />
      <outbound />
      <on-error />
    </policies>
XML

  }
}

resource "azurerm_analysis_services_server" "server" {
  name                    = "analysisservicesserver"
  location                = azurerm_resource_group.tfimportarticle.location
  resource_group_name     = azurerm_resource_group.tfimportarticle.name
  sku                     = "S0"
  admin_users             = ["myuser@domain.tld"]
  enable_power_bi_service = true

  ipv4_firewall_rule {
    name        = "myRule1"
    range_start = "210.117.252.0"
    range_end   = "210.117.252.255"
  }

  tags = {
    abc = 123
  }
}