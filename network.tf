
data "vsphere_host" "hp3" {
  name          = "hp3.mgmt.nilsen-tech.com"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

data "vsphere_host" "hp2" {
  name          = "hp2.mgmt.nilsen-tech.com"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}


# # #dswitch config 
# resource "vsphere_distributed_virtual_switch" "dvs" {
#   name          = "terraform-dvs"
#   datacenter_id = data.vsphere_datacenter.datacenter.id
#  # version       = "7.0.0"

#  # uplinks = ["vmnic3"]

#  # depends_on = [data.vsphere_host.hp3]
#   # Read this https://discuss.hashicorp.com/t/adding-host-to-dvs/34713

#   #standby_uplinks = [ "value" ]

#   # host {
#   #   host_system_id = data.vsphere_host.hp3.id
#   #   devices        = ["vmnic3"]
#   # }

#   # host {
#   #   host_system_id = data.vsphere_host.hp2.id
#   #   devices        = ["vmnic3"]
#   # }

# }


data "vsphere_distributed_virtual_switch" "dvs" {
  name          = "terraform-dvs"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}


# resource "vsphere_distributed_port_group" "portgroup" {

#   for_each = data.terraform_remote_state.Homelabb-Fortigate.outputs.networks.networks.subnets.fortigate_onprem_

#   name                            = replace("${each.key}", "fortigate_onprem_", "")
#   distributed_virtual_switch_uuid = data.vsphere_distributed_virtual_switch.dvs.id
#   vlan_id                         = each.value.vlanid

# }
