include "root" {
	path = find_in_parent_folders("root.hcl")
	expose = true
}

include "provider" {
	path = find_in_parent_folders("provider.hcl")
}

terraform {
	source = "../.."
}

locals {
	admin_group_object_ids = [ "00000000-0000-0000-0000-000000000000", "00000000-0000-0000-0000-000000000000", "00000000-0000-0000-0000-000000000000" ]
	admin_username = "admin_username"
	control_plane_count = 3
	control_plane_vm_sku = "control_plane_vm_sku"
	dns_service_ip = "1.1.1.1"
	pod_cidrs = [ "1.1.1.1/32", "1:1:1::/64" ]
	initial_agent_pool_count = 3
	initial_agent_pool_name = "initial_agent_pool_name"
	initial_agent_pool_vm_sku = "initial_agent_pool_vm_sku"
	ip_address_pool_1_name = "ip_address_pool_1_name"
	ip_address_pool_1_value = "ip_address_pool_1_value"
	ip_address_pool_2_name = "ip_address_pool_2_name"
	ip_address_pool_2_value = "ip_address_pool_2_value"
	ip_address_pool_3_name = "ip_address_pool_3_name"
	ip_address_pool_3_value = "ip_address_pool_3_value"
	ip_address_pool_4_name = "ip_address_pool_4_name"
	ip_address_pool_4_value = "ip_address_pool_4_value"
	kubernetes_version = "kubernetes_version"
	naks_cluster_name = format("%s-naks", local.preamble_version)
	preamble_version = include.root.locals.preamble_version
	service_cidrs = [ "1.1.1.1/32", "1:1:1::/64" ]
	ssh_public_key = "ssh-rsa ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwzyz0123456789"
	stack_name = format("%s-stack", local.naks_cluster_name)
}

inputs = {
	parameters = {
		fabric = {
			csn_name = include.root.locals.csn_name
			custom_location_name = include.root.locals.custom_location_name
			custom_location_rg_name = include.root.locals.custom_location_rg_name
			l3_mgmt_cni_name = include.root.locals.l3_mgmt_cni_name
			l3_test_cni_name = include.root.locals.l3_test_cni_name
		}
		naks_cluster = {
			admin_group_object_ids = local.admin_group_object_ids
			admin_username = local.admin_username
			control_plane_count = local.control_plane_count
			control_plane_vm_sku_name = local.control_plane_vm_sku
			dns_service_ip = local.dns_service_ip
			initial_agent_pool_count = local.initial_agent_pool_count
			initial_agent_pool_name = local.initial_agent_pool_name
			initial_agent_pool_vm_sku_name = local.initial_agent_pool_vm_sku
			ip_address_pool_1_name = local.ip_address_pool_1_name
			ip_address_pool_1_value = local.ip_address_pool_1_value
			ip_address_pool_2_name = local.ip_address_pool_2_name
			ip_address_pool_2_value = local.ip_address_pool_2_value
			ip_address_pool_3_name = local.ip_address_pool_3_name
			ip_address_pool_3_value = local.ip_address_pool_3_value
			ip_address_pool_4_name = local.ip_address_pool_4_name
			ip_address_pool_4_value = local.ip_address_pool_4_value
			kubernetes_version = local.kubernetes_version
			naks_cluster_name = local.naks_cluster_name
			pod_cidrs = local.pod_cidrs
			service_cidrs = local.service_cidrs
			ssh_public_key = local.ssh_public_key
		}
		naks_cluster_rg = {
			naks_cluster_rg_id = include.root.locals.naks_cluster_rg_id
			naks_cluster_rg_name = include.root.locals.naks_cluster_rg_name
		}
	}
	stack_name = local.stack_name
}
