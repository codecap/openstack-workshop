# 1. Create the private network
resource "openstack_networking_network_v2" "private_network" {
  name           = var.network_name
  admin_state_up = true
}

# 2. Create the private subnet
resource "openstack_networking_subnet_v2" "private_subnet" {
  name            = var.subnet_name
  network_id      = openstack_networking_network_v2.private_network.id
  cidr            = var.subnet_cidr
  ip_version      = 4
  # dns_nameservers = ["8.8.8.8", "1.1.1.1"] # Highly recommended for instance internet access
}

# 3. Create a router and connect it to the public gateway & private subnet
data "openstack_networking_network_v2" "public_network" {
  name = var.public_network
}

resource "openstack_networking_router_v2" "router" {
  name                = var.router_name
  external_network_id = data.openstack_networking_network_v2.public_network.id
}

resource "openstack_networking_router_interface_v2" "router_interface" {
  router_id = openstack_networking_router_v2.router.id
  subnet_id = openstack_networking_subnet_v2.private_subnet.id
}

# 4. Create a Security Group
resource "openstack_networking_secgroup_v2" "sec_group" {
  name        = var.sec_group_name
  description = "Allow SSH and ICMP traffic"
}

# 5. Allow SSH Inbound Rule
resource "openstack_networking_secgroup_rule_v2" "allow_ssh" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "tcp"
  port_range_min    = 22
  port_range_max    = 22
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.sec_group.id
}

# 6. Allow ICMP Inbound Rule
resource "openstack_networking_secgroup_rule_v2" "allow_icmp" {
  direction         = "ingress"
  ethertype         = "IPv4"
  protocol          = "icmp"
  remote_ip_prefix  = "0.0.0.0/0"
  security_group_id = openstack_networking_secgroup_v2.sec_group.id
}

# 7. Upload local public key to OpenStack project
resource "openstack_compute_keypair_v2" "keypair" {
  name       = var.key_name
  public_key = file(var.local_key_path)
}

# 8. Launch the server instance
resource "openstack_compute_instance_v2" "server" {
  name            = var.server_name
  image_name      = var.image_name
  flavor_name     = var.flavor_name
  key_pair        = openstack_compute_keypair_v2.keypair.name
  security_groups = [openstack_networking_secgroup_v2.sec_group.name]

  network {
    uuid = openstack_networking_network_v2.private_network.id
  }

  # Ensure the subnet and router interface exist before building the instance
  depends_on = [openstack_networking_router_interface_v2.router_interface]
}

# 9. Create a persistent block volume
resource "openstack_blockstorage_volume_v3" "volume" {
  name = var.volume_name
  size = var.volume_size
}

# 10. Attach the volume to the server
resource "openstack_compute_volume_attach_v2" "volume_attach" {
  instance_id = openstack_compute_instance_v2.server.id
  volume_id   = openstack_blockstorage_volume_v3.volume.id
  device      = "/dev/vdb"
}

# 11. Allocate and assign a floating IP to the server
resource "openstack_networking_floatingip_v2" "fip" {
  pool = var.public_network
  # address = var.fip_addr
}

resource "openstack_compute_floatingip_associate_v2" "fip_assoc" {
  floating_ip = openstack_networking_floatingip_v2.fip.address
  instance_id = openstack_compute_instance_v2.server.id
}

# 12. Output Connection Details
output "instance_floating_ip" {
  value       = openstack_networking_floatingip_v2.fip.address
  description = "The allocated floating IP address assigned to the server instance."
}
