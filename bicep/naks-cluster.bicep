targetScope = 'resourceGroup'

// ============================================================
// PARAMETERS
// ============================================================

param admin_group_object_ids array
param admin_username string
param control_plane_count int
param control_plane_vm_sku_name string
param csn_name string
param custom_location_name string
param custom_location_rg_name string
param dns_service_ip string
param ip_address_pool_1_name string
param ip_address_pool_1_value string
param ip_address_pool_2_name string
param ip_address_pool_2_value string
param ip_address_pool_3_name string
param ip_address_pool_3_value string
param ip_address_pool_4_name string
param ip_address_pool_4_value string
param initial_agent_pool_count int
param initial_agent_pool_name string
param initial_agent_pool_vm_sku_name string
param kubernetes_version string
param l3_mgmt_cni_name string
param l3_test_cni_name string
param location string = resourceGroup().location
param naks_cluster_name string
param pod_cidrs array
param service_cidrs array
param ssh_public_key string

// ============================================================
// EXISTING EXTENDED LOCATION
// ============================================================

resource customLocation 'Microsoft.ExtendedLocation/customLocations@2021-08-15' existing = {
  // This is the resource group Azure reported in the error
  scope: resourceGroup(custom_location_rg_name)
  name: custom_location_name
}

// ============================================================
// EXISTING NETWORK RESOURCES
// ============================================================

resource l3NetworkMgmt 'Microsoft.NetworkCloud/l3Networks@2026-01-01-preview' existing = {
  name: l3_mgmt_cni_name
}

resource l3NetworkTest 'Microsoft.NetworkCloud/l3Networks@2026-01-01-preview' existing = {
  name: l3_test_cni_name
}

resource cloudServicesNetwork 'Microsoft.NetworkCloud/cloudServicesNetworks@2026-01-01-preview' existing = {
  name: csn_name
}

// ============================================================
// KUBERNETES CLUSTER
// ============================================================

resource naks 'Microsoft.NetworkCloud/kubernetesClusters@2026-01-01-preview' = {
  name: naks_cluster_name
  location: location

  extendedLocation: {
    name: customLocation.id
    type: 'CustomLocation'
  }

  properties: {
    kubernetesVersion: kubernetes_version

    aadConfiguration: {
      adminGroupObjectIds: admin_group_object_ids
    }

    administratorConfiguration: {
      adminUsername: admin_username
      sshPublicKeys: [
        {
          keyData: ssh_public_key
        }
      ]
    }

    controlPlaneNodeConfiguration: {
      count: control_plane_count
      vmSkuName: control_plane_vm_sku_name

      administratorConfiguration: {
        adminUsername: admin_username
        sshPublicKeys: [
          {
            keyData: ssh_public_key
          }
        ]
      }
    }

    initialAgentPoolConfigurations: [
      {
        name: initial_agent_pool_name
        mode: 'System'
        count: initial_agent_pool_count
        vmSkuName: initial_agent_pool_vm_sku_name

        agentOptions: {
          hugepagesCount: 2
          hugepagesSize: '1G'
        }

        administratorConfiguration: {
          adminUsername: admin_username
          sshPublicKeys: [
            {
              keyData: ssh_public_key
            }
          ]
        }
      }
    ]

    networkConfiguration: {
      cloudServicesNetworkId: cloudServicesNetwork.id
      cniNetworkId: l3NetworkMgmt.id

      podCidrs: pod_cidrs
      serviceCidrs: service_cidrs
      dnsServiceIp: dns_service_ip

      attachedNetworkConfiguration: {
        l3Networks: [
          {
            ipamEnabled: 'True'
            networkId: l3NetworkTest.id
            pluginType: 'SRIOV'
          }
        ]
      }

      bgpServiceLoadBalancerConfiguration: {
        bgpAdvertisements: []
        bgpPeers: []
        fabricPeeringEnabled: 'True'

        ipAddressPools: [
          {
            name: ip_address_pool_1_name
            addresses: [
              ip_address_pool_1_value
            ]
            autoAssign: 'True'
          }
          {
            name: ip_address_pool_2_name
            addresses: [
              ip_address_pool_2_value
            ]
            autoAssign: 'True'
          }
          {
            name: ip_address_pool_3_name
            addresses: [
              ip_address_pool_3_value
            ]
            autoAssign: 'True'
          }
          {
            name: ip_address_pool_4_name
            addresses: [
              ip_address_pool_4_value
            ]
            autoAssign: 'True'
          }
        ]
      }
    }
  }
}

output managed_rg_name string = naks.properties.managedResourceGroupConfiguration.name

