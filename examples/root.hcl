locals {
	app_tag = "cyperf"
	app_version = "26.1.0"
	app_version_tag = replace(local.app_version, ".", "-")
	csn_name = "fabric-csn-name"
	custom_location_name = "fabric-custom-location-name"
	custom_location_rg_name = "fabric-custom-location-rg-name"
	l3_mgmt_cni_name = "l3-mgmt-cni-name"
	l3_test_cni_name = "l3-test-cni-name"
	naks_cluster_rg_id = format("/subscriptions/%s/resourceGroups/%s", local.subscription_id, local.naks_cluster_rg_name)
	naks_cluster_rg_name = "naks-cluster-rg-name"
	preamble = format("%s-%s-%s", local.user_login_tag, local.user_project_tag, local.app_tag)
	preamble_version = format("%s-%s", local.preamble, local.app_version_tag)
	subscription_id = "00000000-0000-0000-0000-000000000000"
	user_login_tag = "jadupre"
	user_project_tag = "aon"
}
