variable "network_name"   { default = "trf-private" }
variable "subnet_name"    { default = "trf-private-subnet" }
variable "subnet_cidr"    { default = "192.168.20.0/24" }
variable "router_name"    { default = "trf-router" }
variable "public_network" { default = "shared3010" }

variable "sec_group_name" { default = "trf-secgroup" }
variable "key_name"       { default = "trf-my-key" }
variable "local_key_path" { default = "~/.ssh/id_ecdsa.pub" }

variable "server_name"    { default = "trf-server01" }
variable "image_name"     { default = "ubuntu-24.04" }
variable "flavor_name"    { default = "m1.small" }

variable "fip_addr"       { default = "10.30.10.220" }

variable "volume_name"    { default = "trf-vol-server01" }
variable "volume_size"    { default = 10 }
