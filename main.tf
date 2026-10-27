resource "azapi_resource" "stack" {
	type = "Microsoft.Resources/deploymentStacks@2024-03-01"
	name = local.stack_name
	parent_id = local.resource_group_id

	response_export_values = [ "*" ]

	body = {
		properties = {
			actionOnUnmanage = {
				resources = "delete"
			}
			denySettings = {
				mode = "none"
			}
			template= jsondecode(file(local.stack_file))
			parameters = local.stack_params
		}
	}
}
