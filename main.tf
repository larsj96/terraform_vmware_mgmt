terraform {
  required_providers {
    vsphere = {
      source = "hashicorp/vsphere"
      version = "2.2.0"
    }
  }
  backend "http" {
  }

  
}

provider "vsphere" {
  # Configuration options
 allow_unverified_ssl =  var.allow_unverified_ssl
}