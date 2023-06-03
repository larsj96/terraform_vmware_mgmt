

data "tfe_outputs" "Homelabb-Fortigate" {

  organization = "lanilsen"
  workspace = "fortigate"
}




data "vsphere_datacenter" "datacenter" {
  name = "datacenter"
}

data "vsphere_host" "hp3" {
  name          = "hp3.mgmt.nilsen-tech.com"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

# data "vsphere_host" "hp2" {
#  name          = "hp2.mgmt.nilsen-tech.com"
#  datacenter_id = data.vsphere_datacenter.datacenter.id
#}

data "vsphere_distributed_virtual_switch" "dvs" {
  name          = "terraform-dvs"
  datacenter_id = data.vsphere_datacenter.datacenter.id
}

# locals {
#   vlans = data.terraform_remote_state.Homelabb-Fortigate.outputs
# }
