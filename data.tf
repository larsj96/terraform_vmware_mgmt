data "terraform_remote_state" "Homelabb-Fortigate" {
  backend = "remote"

  config = {
    organization = "lanilsen"
    workspaces = {

      name = "Homelabb-Fortigate"
    }
  }
}

data "vsphere_datacenter" "datacenter" {
  name = "datacenter"
}

locals {
  vlans = data.terraform_remote_state.Homelabb-Fortigate.outputs
}
