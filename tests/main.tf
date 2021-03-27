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