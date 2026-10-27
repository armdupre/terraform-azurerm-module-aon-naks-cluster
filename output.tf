output parameters {
	value = {
		fabric = {
			csn_name = local.fabric.csn_name
			custom_location_name = local.fabric.custom_location_name
			custom_location_rg_name = local.fabric.custom_location_rg_name
			l3_mgmt_cni_name = local.fabric.l3_mgmt_cni_name
			l3_test_cni_name = local.fabric.l3_test_cni_name
		}
		naks_cluster = {
			admin_group_object_ids = local.naks_cluster.admin_group_object_ids
			admin_username = local.naks_cluster.admin_username
			control_plane_count = local.naks_cluster.control_plane_count
			control_plane_vm_sku_name = local.naks_cluster.control_plane_vm_sku_name
			dns_service_ip = local.naks_cluster.dns_service_ip
			initial_agent_pool_count = local.naks_cluster.initial_agent_pool_count
			initial_agent_pool_name = local.naks_cluster.initial_agent_pool_name
			initial_agent_pool_vm_sku_name = local.naks_cluster.initial_agent_pool_vm_sku_name
			kubernetes_version = local.naks_cluster.kubernetes_version
			naks_cluster_name = local.naks_cluster.naks_cluster_name
			pod_cidrs = local.naks_cluster.pod_cidrs
			service_cidrs = local.naks_cluster.service_cidrs
			ssh_public_key = local.naks_cluster.ssh_public_key
		}
		naks_cluster_rg = {
			naks_cluster_rg_id = local.naks_cluster_rg.naks_cluster_rg_id
			naks_rg_location = local.naks_cluster_rg.naks_cluster_rg_location
			naks_cluster_rg_name = local.naks_cluster_rg.naks_cluster_rg_name
		}
	}
}

output stack {
	value = {
		connected_cluster_id = format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.Kubernetes/connectedClusters/%s",
										local.subscription_id,
										local.stack.properties.outputs.managed_rg_name.value,
										local.naks_cluster.naks_cluster_name)
		managed_rg_name = local.stack.properties.outputs.managed_rg_name.value
		stack_name = azapi_resource.stack.name
	}
}
