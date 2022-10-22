
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



# resource "vsphere_distributed_port_group" "portgroup" {

#   for_each = data.terraform_remote_state.Homelabb-Fortigate.outputs.networks.networks.subnets.fortigate_onprem_

#   name                            = replace("${each.key}", "fortigate_onprem_", "")
#   distributed_virtual_switch_uuid = data.vsphere_distributed_virtual_switch.dvs.id
#   vlan_id                         = each.value.vlanid

# }


locals {
  # If we allocate two addressing bits to regions and
  # three addressing bits to subnett then we can have
  # up to four regions and up to eight subnett, with
  # each zone then requiring five subnet addressing
  # bits in total.
  regions = {
    fortigate_onprem_ = 0
    azure_north_eu_   = 1
    # number 3 available for future expansion
  }
  subnett = {
    k8s     = 1
    dns     = 2
    bastion = 3
    gitlab  = 4
    vmware  = 5
  }

  base_cidr_block = "10.0.0.0/16"
  region_blocks = {
    for name, num in local.regions : name => {
      cidr_block = cidrsubnet(local.base_cidr_block, 4, num)
    }
  }
  subnetts_block = {
    for name, region_num in local.regions : name => {
      for letter, num in local.subnett : "${name}${letter}" => {
        cidr_block = cidrsubnet(local.region_blocks[name].cidr_block, 7, num)
        vlanid     = "${01}${num + 1}"
      }
    }
  }
}



resource "vsphere_distributed_port_group" "portgroup" {
  for_each = local.subnetts_block.fortigate_onprem_

  vlan_id                         = each.value.vlanid
  distributed_virtual_switch_uuid = data.vsphere_distributed_virtual_switch.dvs.id
  name                            = replace("${each.key}", "fortigate_onprem_", "")

}
