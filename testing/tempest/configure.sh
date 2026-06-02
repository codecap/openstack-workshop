#!/bin/bash
tempest_version=45
workspace_name="tempest-$tempest_version"
workspace="$HOME/$workspace_name"

tempest init $workspace

public_net_id=$(openstack network show shared3010 -f value -c id)
volume_backend_names=$(openstack volume type list  -f value -c Name | xargs | tr "[ ]" "[,]")
test_image_id=$(openstack image list -f value | grep cirros | sort -Vk 2 | tail -n1  | awk '{print $1}')
test_flavor_id=$(openstack flavor show m1.tiny -f value -c id)

cat > $workspace/etc/tempest.conf <<EOF
#
# Link: https://docs.openstack.org/tempest/latest/sampleconf.html
#
[DEFAULT]
log_dir = $workspace/logs
log_file = tempest.log
debug = False

[oslo_concurrency]
lock_path = $workspace/tempest_lock

[identity]
uri_v3 = http://int.os.wrx.sckt.net:5000/v3
auth_version = v3
region = RegionOne
v3_endpoint_type = internalURL

[auth]
#test_accounts_file = $workspace/etc/accounts.yml
#use_dynamic_credentials = False
admin_username = admin
admin_password = $OS_PASSWORD
admin_project_name = admin
admin_domain_name = Default


[network]
public_network_id = $public_net_id
floating_network_name = $public_net_id
endpoint_type = internalURL

[service_available]
neutron = true


[compute]
image_ref      = $test_image_id
image_ref_alt  = $test_image_id
flavor_ref     = $test_flavor_id
flavor_ref_alt = $test_flavor_id
endpoint_type = internalURL

[validation]

connect_method = floating
image_ssh_user = cirros
image_ssh_password = gocubsgo
#ping_timeout = 60

[volume]

backend_names = $volume_backend_names
#build_interval = 1
#build_timeout = 300
#disk_format = raw
#volume_size = 1
endpoint_type = internalURL

[volume-feature-enabled]
multi_backend = true
EOF

#
# Worker Configuration
#
# cat <<EOF
# # YAML Worker file
# - worker:
#   # you can have more than one regex per worker
#   - tempest.*
#   # - tempest.api.*
#   # - neutron_tempest_tests
#   concurrency: 4
# EOF

#
# List of Tests
#
# stestr list > tests-available.list
# cat $workspace/tests-available.list \
#     | grep smoke \
#     | egrep -v "object_storage" \
#     > smoke-tests.list
