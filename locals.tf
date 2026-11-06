locals {
	fabric = var.parameters.fabric
	naks_cluster = var.parameters.naks_cluster
	naks_cluster_rg = var.parameters.naks_cluster_rg
	resource_group_id = local.naks_cluster_rg.naks_cluster_rg_id
	stack_name = var.stack_name
	subscription_id = data.azurerm_client_config.current.subscription_id
}

locals {
	params = {
		admin_group_object_ids = local.naks_cluster.admin_group_object_ids
		admin_username = local.naks_cluster.admin_username
		control_plane_count = local.naks_cluster.control_plane_count
		control_plane_vm_sku_name = local.naks_cluster.control_plane_vm_sku_name
		csn_name = local.fabric.csn_name
		custom_location_name = local.fabric.custom_location_name
		custom_location_rg_name = local.fabric.custom_location_rg_name
		dns_service_ip = local.naks_cluster.dns_service_ip
		initial_agent_pool_count = local.naks_cluster.initial_agent_pool_count
		initial_agent_pool_name = local.naks_cluster.initial_agent_pool_name
		initial_agent_pool_vm_sku_name = local.naks_cluster.initial_agent_pool_vm_sku_name
		ip_address_pool_1_name = local.naks_cluster.ip_address_pool_1_name
		ip_address_pool_1_value = local.naks_cluster.ip_address_pool_1_value
		ip_address_pool_2_name = local.naks_cluster.ip_address_pool_2_name
		ip_address_pool_2_value = local.naks_cluster.ip_address_pool_2_value
		ip_address_pool_3_name = local.naks_cluster.ip_address_pool_3_name
		ip_address_pool_3_value = local.naks_cluster.ip_address_pool_3_value
		ip_address_pool_4_name = local.naks_cluster.ip_address_pool_4_name
		ip_address_pool_4_value = local.naks_cluster.ip_address_pool_4_value
		kubernetes_version = local.naks_cluster.kubernetes_version
		l3_mgmt_cni_name = local.fabric.l3_mgmt_cni_name
		l3_test_cni_name = local.fabric.l3_test_cni_name
		naks_cluster_name = local.naks_cluster.naks_cluster_name
		pod_cidrs = local.naks_cluster.pod_cidrs
		service_cidrs = local.naks_cluster.service_cidrs
		ssh_public_key = local.naks_cluster.ssh_public_key
	}
	stack = azapi_resource.stack.output
	stack_file = "${path.module}/compiled/naks-cluster.json"
	stack_params = { for k, v in local.params : k => { value = v } }
}
