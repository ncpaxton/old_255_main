terraform {
  required_version = "<1.2.0, > 1.1.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>2.0"
    }
  }
}

provider "azurerm" {
  features {}

  tenant_id       = "cba533e6-d004-4e85-8d96-8f0a22c908a5"
  subscription_id = "414b4da1-b6dd-480a-a797-cb14ea566766"
}
