terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.2.0"
    }
  }
}

provider "vsphere" {
  # Configuration options

 allallow_unverified_ssl =  var.allow_unverified_ssl
}