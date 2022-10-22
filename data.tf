data "terraform_remote_state" "Homelabb-Fortigate" {
  backend = "http"

  config = { # this is the state for FORTIGATE project
    address = "http://10.0.0.130/api/v4/projects/2/terraform/state/main" # TF_HTTP_ADDRESS env variable
    username = "terraform"
  #  password = "XXXXXXXX"
  }
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
