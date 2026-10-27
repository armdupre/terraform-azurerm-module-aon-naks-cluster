variable parameters {
	type = object({
		fabric = object({
			csn_name = string
			custom_location_name = string
			custom_location_rg_name = string
			l3_mgmt_cni_name = string
			l3_test_cni_name = string
		})
		naks_cluster = object({
			admin_group_object_ids = list(string)
			admin_username = string
			control_plane_count = number
			control_plane_vm_sku_name = string
			dns_service_ip = string
			initial_agent_pool_count = number
			initial_agent_pool_name = string
			initial_agent_pool_vm_sku_name = string
			kubernetes_version = string
			naks_cluster_name = string
			pod_cidrs = list(string)
			service_cidrs = list(string)
			ssh_public_key = string
		})
		naks_cluster_rg = object({
			naks_cluster_rg_id = string
			naks_cluster_rg_location = optional(string, "uksouth")
			naks_cluster_rg_name = string
		})
	})
}

variable stack_name {
	type = string
}
