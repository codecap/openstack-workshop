terraform {
required_version = ">= 0.14.0"
  required_providers {
    openstack = {
      source  = "terraform-provider-openstack/openstack"
      version = "~> 1.53.0"
    }
  }
}

variable "os_password" {
  type = string
  description = "Openstack password"
}
provider "openstack"{
  user_name   = "automation"
  tenant_name = "automation"
  password    = var.os_password
  auth_url    = "http://int.os.wrx.sckt.net:5000/v3"
  region      = "RegionOne"
}
