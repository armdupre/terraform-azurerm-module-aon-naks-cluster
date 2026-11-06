locals {
	root = read_terragrunt_config("../root.hcl")
}

generate "provider" {
	path = "provider.tf"
	if_exists = "overwrite"

	contents = <<EOF
provider "azurerm" {
	features {}
}
provider "azapi" {
	use_cli = true
	use_msi = false
}
EOF
}
