terraform {
	required_version = ">= 1.5.7"
	required_providers {
		azapi = {
			source  = "Azure/azapi"
			version = "~> 1.13"
		}
		azurerm = {
			source  = "hashicorp/azurerm"
			version = ">= 4.81.0"
		}
	}
}
