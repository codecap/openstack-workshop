---
title:       OpenStack
description: OpenStack & Ceph
author:      Vladislav Nazarenko (vnazarenko@📯socket.de)
keywords:    openstack,ceph,workshops,operations,troubleshoouting
url:
image:
backgroundImage: url(https://raw.githubusercontent.com/codecap/openstack-workshop/refs/heads/main/assets/background.jpg)
transition: cover
paginate: true
footer: Questions or need a guided workshop? → ping@socket.de
style: |
  footer {
    font-size: 7px;
    text-align: left;
  }
  .mermaid {
    text-align: center;
  }
  .mermaid svg {
    width:  50%;
    height: 50%;    
  }
---
<script type="module">
import mermaid from 'https://cdn.jsdelivr.net/npm/mermaid@11/dist/mermaid.esm.min.mjs';
mermaid.initialize({ startOnLoad: true, theme: 'default' });
</script>

# OpenStack
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)


[//]: # (https://docs.redhat.com/en/documentation/red_hat_openstack_platform/9/html/architecture_guide/components)
[//]: # (https://cloudification.io/cloud-blog/openstack-microservice-architecture-main-components/)
[//]: # (https://canonical-openstack.readthedocs-hosted.com/en/latest/explanation/)
[//]: # (https://www.freecodecamp.org/news/openstack-tutorial-operate-your-own-private-cloud/)
[//]: # (https://superuser.openinfra.org/articles/kolla-ansible-openstack-installation-ubuntu-24-04/)


[//]: # (TODO: monitoring - node-exporter full)
[//]: # (TODO: monitoring - cadvisor)
[//]: # (TODO: monitoring - libvirt)
[//]: # (TODO: monitoring - Prom)
[//]: # (TODO: monitoring - Alertmanager)
[//]: # (TODO: monitoring - RabbitMQ)


---
# Architecture

![ bg right:65% 80%](https://www.openstack.org/static/000588f8b89d94da80eba6101f72ff7a/openstack-map-v20240401.png)

---
# Architecture

![ bg right:65% 80%](https://access.redhat.com/webassets/avalon/d/Red_Hat_OpenStack_Platform-9-Architecture_Guide-en-US/images/fce6394275bd3444892c5d3a91ccf17c/RHEL_OSP_arch_347192_1015_JCS_01_Interface-Overview.png)

---
# Architecture

![ bg right:65% 80%](https://pure-storage-openstack-docs.readthedocs.io/en/zed_a/_images/openstack_architecture.png)

---
# Architecture
![ bg right:65% 80%](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_897/https%3A%2F%2Fassets.ubuntu.com%2Fv1%2F27493de3-Canonical%20OpenStack%20architecture%20diagram.png)


---
# Architecture
![ bg right:65% 80%](https://access.redhat.com/webassets/avalon/d/Red_Hat_OpenStack_Platform-9-Architecture_Guide-en-US/images/c6afcf33c1422e761f467c40b6980396/RHEL_OSP_arch_347192_1015_JCS_Ex-Basic-Arch.png)


---
# Architecture
![ bg right:65% 80%](https://access.redhat.com/webassets/avalon/d/Red_Hat_OpenStack_Platform-9-Architecture_Guide-en-US/images/ef505e423b37c7cbecbe6dfa4021f384/RHEL_OSP_arch_347192_1015_JCS_04_Interface-Identity.png)

---
# Architecture
![ bg right:65% 80%](https://access.redhat.com/webassets/avalon/d/Red_Hat_OpenStack_Platform-8-Architecture_Guide-en-US/images/661ccaef79099e48e1d4e33e48e52cfc/RHEL_OSP_arch_347192_1015_JCS_05_Interface-Networking.png)

---
# Architecture
![ bg right:65% 80%](https://access.redhat.com/webassets/avalon/d/Red_Hat_OpenStack_Platform-8-Architecture_Guide-en-US/images/aa867c517b4e6f46edf34efb04eba1cb/RHEL_OSP_arch_347192_1015_JCS_06_Interface-Block-Storage.png)


---
# Architecture
![ bg right:65% 80%](https://access.redhat.com/webassets/avalon/d/Red_Hat_OpenStack_Platform-8-Architecture_Guide-en-US/images/59429a3c3b9440fe0441da62a3095a9a/RHEL_OSP_arch_347192_1015_JCS_07_Interface-Compute.png)

---
# Architecture
![ bg right:65% 80%](https://access.redhat.com/webassets/avalon/d/Red_Hat_OpenStack_Platform-8-Architecture_Guide-en-US/images/3d273bee788ec5deb1fd11a22b7e1487/RHEL_OSP_arch_347192_1015_JCS_08_Interface-Image.png)

---
# Architecture
![ bg right:65% 80%](https://access.redhat.com/webassets/avalon/d/Red_Hat_OpenStack_Platform-9-Architecture_Guide-en-US/images/05df8dacdfb319319665befc022e4159/RHEL_OSP_arch_347192_1015_JCS_02_Interface-Dashboard.png)


---
# Users

![bg right:75% 80%](https://www.svgrepo.com/show/303419/walmart-logo.svg)
![bg right:75% 80%](https://www.svgrepo.com/show/303330/nasa-6-logo.svg)
![bg right:75% 80%](https://upload.wikimedia.org/wikipedia/de/c/c2/Huawei-Logo.svg)
![bg right:75% 80%](https://www.svgrepo.com/show/331321/blizzard.svg)
![bg right:75% 80%](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_239/https%3A%2F%2Fassets.ubuntu.com%2Fv1%2F57c722c5-cern-logo.png)
![bg right:75% 80%](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_313/https%3A%2F%2Fassets.ubuntu.com%2Fv1%2F60fd1f45-deutsche-telekom.png)
![bg right:75% 80%](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_313/https%3A%2F%2Fassets.ubuntu.com%2Fv1%2F1e543d4d-Bloomberg-Logo.png)

---
# Contributors
![bg right:60% 80%](https://www.svgrepo.com/show/354271/redhat.svg)
![bg right:60% 80%](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_348/https%3A%2F%2Fassets.ubuntu.com%2Fv1%2F1c72c15a-canonical-logo.png)
![bg right:60% 80%](https://upload.wikimedia.org/wikipedia/commons/a/a4/Mirantis_logo.svg)
![bg right:60% 80%](https://upload.wikimedia.org/wikipedia/de/c/c2/Huawei-Logo.svg)
![bg right:60% 80%](https://res.cloudinary.com/canonical/image/fetch/f_auto,q_auto,fl_sanitize,w_189/https%3A%2F%2Fassets.ubuntu.com%2Fv1%2Fc3382d32-cisco-logo.png)
![bg right:60% 80%](https://www.svgrepo.com/show/303630/nvidia-logo.svg)
![bg right:60% 80%](https://www.svgrepo.com/show/349412/intel.svg)


---
# Deploy OpenStack
![bg right:30% 90%](https://superuser.openinfra.org/wp-content/uploads/2025/01/1_q6dlalwfoVWwUqFmo4I-9g.png)


---
# Deploy OpenStack
![bg right:30% 90%](https://superuser.openinfra.org/wp-content/uploads/2025/01/1_q6dlalwfoVWwUqFmo4I-9g.png)
```
# Prepare environment                                                       📋
cat >> ~/.profile <<"EOF"
##############################################################################
# openstack vars

export OPENSTACK_DIR=~/openstack
VENV_PATH=~/venv/2024.1
KOLLA_ANSIBLE_RELEASE=18 # OS 2024.1
# KOLLA_ANSIBLE_RELEASE=20 # OS 2025.1

if [ -z "$VIRTUAL_ENV" ]
then
  source ~/venv/openstack/bin/activate
fi
export ARA_HOME=$VIRTUAL_ENV/lib/python3.12/site-packages/ara


ADMIN_OPENRC_FILE=$OPENSTACK_DIR/custom-config/tst/admin-openrc.sh
if [ -f $ADMIN_OPENRC_FILE ]
then
  source  $ADMIN_OPENRC_FILE
fi

export PATH=~/openstack/bin/:$PATH
export PS1="[\u@\h \W|\[\e[1;32m\]\$OS_USERNAME.\$OS_PROJECT_NAME\[\e[m\]]\$"
alias wrx-stack='tmuxp load -y ~/openstack-workshop/conf/tmuxp.yaml'
source <(openstack complete)
EOF
```

---
# Deploy OpenStack
![bg right:30% 90%](https://superuser.openinfra.org/wp-content/uploads/2025/01/1_q6dlalwfoVWwUqFmo4I-9g.png)

```bash
# Prepare python virtual environment                                        📋



source ~/.profile

python3 -m venv $VENV_PATH

ln -s  $VENV_PATH ~/venv/openstack
source $VENV_PATH/bin/activate

pip install -U pip
pip install -r requirements.txt

# Insall dependencie for kolla-ansible
kolla-ansible install-deps
# NOTE: fix for prometheus 05.2026
pip install "bcrypt<5.0.0"

# Install additional dependencies
gilt overlay
```

---
# Deploy OpenStack
![bg right:30% 90%](https://superuser.openinfra.org/wp-content/uploads/2025/01/1_q6dlalwfoVWwUqFmo4I-9g.png)
```bash
# Prepare ansible inventory                                                 📋

# Copy invenotry file
cp ~/venv/openstack/share/kolla-ansible/ansible/inventory/multinode inventory/

# Patch inventory file and review inventory/wrx/ directory afterwords
crudini --del inventory/multinode control
crudini --del inventory/multinode network
crudini --del inventory/multinode compute
crudini --del inventory/multinode monitoring
crudini --del inventory/multinode storage
crudini --del inventory/multinode loadbalancer:children

# Prapare passwords
cp ~/venv/openstack/share/kolla-ansible/etc_examples/kolla/passwords.yml \
  custom-config/wrx/passwords.yml

kolla-genpwd -p custom-config/wrx/passwords.yml
```

---
# Deploy OpenStack
![bg right:30% 90%](https://superuser.openinfra.org/wp-content/uploads/2025/01/1_q6dlalwfoVWwUqFmo4I-9g.png)
```bash
# Overview of kolla-ansible commands                                        📋

kolla-ansible bootstrap-servers    -i inventory/wrx
kolla-ansible octavia-certificates -i inventory/wrx
kolla-ansible prechecks            -i inventory/wrx
kolla-ansible pull                 -i inventory/wrx
kolla-ansible deploy               -i inventory/wrx  -vvvv
kolla-ansible post-deploy          -i inventory/wrx
kolla-ansible check                -i inventory/wrx
kolla-ansible destroy              -i inventory/wrx <--yes-i-really-really-mean-it>
kolla-ansible mariadb_recovery     -i inventory/wrx
kolla-ansible reconfigure          -i inventory/wrx
kolla-ansible upgrade              -i inventory/wrx
kolla-ansible stop                 -i inventory/wrx
kolla-ansible deploy-containers    -i inventory/wrx
kolla-ansible prune-images         -i inventory/wrx
```

---
# Deploy OpenStack
![bg right:30% 90%](https://superuser.openinfra.org/wp-content/uploads/2025/01/1_q6dlalwfoVWwUqFmo4I-9g.png)
```bash
# Prepare the kolla-ansible deployment                                      📋

kolla-ansible bootstrap-servers    -i inventory/wrx
kolla-ansible octavia-certificates -i inventory/wrx
kolla-ansible prechecks            -i inventory/wrx

# NOTE: this will take time
kolla-ansible pull                 -i inventory/wrx
```

---
# Deploy OpenStack
![bg right:30% 90%](https://superuser.openinfra.org/wp-content/uploads/2025/01/1_q6dlalwfoVWwUqFmo4I-9g.png)
```bash
# Prepare the kolla-ansible deployment                                      📋

# NOTE: it will take time
kolla-ansible deploy               -i inventory/wrx

# Post deployment steps
kolla-ansible post-deploy          -i inventory/wrx
kolla-ansible check                -i inventory/wrx
```

---
# Deploy OpenStack
![bg right:30% 90%](https://superuser.openinfra.org/wp-content/uploads/2025/01/1_q6dlalwfoVWwUqFmo4I-9g.png)
```bash
# Create a test deployment                                                  📋

#FIXME: IPs
KOLLA_CONFIG_PATH=~/openstack/custom-config/wrx/    \
EXT_NET_CIDR=10.10.61.0/24                          \
EXT_NET_GATEWAY=10.10.61.1                          \
EXT_NET_RANGE="start=10.10.61.240,end=10.10.61.245" \
~/venv/2024.1/share/kolla-ansible/init-runonce
```


---
# Service Overview
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)

---
# Praxis
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)
- create a project / user
- create networks
- create router
- create vms
...
- live migraions

---
# Operations
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)

---
# Replace a Compute Node
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)

---
# Replace a Network Node
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)

---
# Replace a Controller Node
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)

---
# Upgrades
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)

---
# High Availbility
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)

---
# Debugging
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)

```bash
rabbitmqctl list_queues name,messages,messages_ready,messages_unacknowledged
rabbitmqctl list_bindings 

rabbitmqctl purge_queue <QUEUE_NAME>

rabbitmqctl delete_queue  <QUEUE_NAME>cinder-scheduler


grep -r [RESOUCE_ID] /var/log/kolla/


virsh list

ip netns

```
---
# Backup and Recovery
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)
- OpenStack environment
- An environment within openstack

---
# Monitoring / Logging
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)
* Ceilometer / Gnochi / Aodh (for Billing)
* Prmetheus / Alertmanager / Grafana (for general monitoring)
* Central Logging (OpenSearch)

---
# Images
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)
```bash
# Download and install some images                                          📋
mkdir -p  ~/cloud-images/

ALMA_VERSION="10.1"
ALMA_IMG_NAME=$(
  curl -sS https://repo.almalinux.org/almalinux/10/cloud/x86_64/images/CHECKSUM  \
   | grep GenericCloud-$ALMA_VERSION | awk '{print $2}' |  sort  | tail -n1)
ALMA_LINK=https://repo.almalinux.org/almalinux/10/cloud/x86_64/images/$ALMA_IMG_NAME

ROCKY_VERSION="10.1"
ROCKY_IMG_NAME=$(
  curl -sS https://dl.rockylinux.org/pub/rocky/10/images/x86_64/CHECKSUM \
  | grep SHA256 | awk '{print $2}'  | grep GenericCloud-LVM-$ROCKY_VERSION \
  | sed -e "s/[()]//g" | sort | tail -n1)
ROCKY_LINK=https://dl.rockylinux.org/pub/rocky/10/images/x86_64/$ROCKY_IMG_NAME

UBUNTU_VERSION="24.04"
UBUNTU_IMG_NAME=noble-server-cloudimg-amd64.img
UBUNTU_LINK="https://cloud-images.ubuntu.com/noble/current/$UBUNTU_IMG_NAME"

DEBIAN_VERSION="13"
DEBIAN_IMG_NAME=debian-13-generic-amd64.qcow2
DEBIAN_LINK="https://cloud.debian.org/images/cloud/trixie/latest/$DEBIAN_IMG_NAME"
```

---
# Images
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)
```bash
#                                                                           📋
for i in  alma~$ALMA_VERSION~$ALMA_LINK       \
          rocky~$ROCKY_VERSION~$ROCKY_LINK    \
          ubuntu~$UBUNTU_VERSION~$UBUNTU_LINK \
          debian~$DEBIAN_VERSION~$DEBIAN_LINK
do
  IFS="~" read -r -a fields <<< $i
  name=${fields[0]}
  version=${fields[1]}
  link=${fields[2]}
  filepath=~/cloud-images/$(basename $link)

  echo "Downloadig $name-$version image"
  curl --output-dir ~/cloud-images -L -O $link

  echo "Uploading $name-$version image into OpenStack"
  openstack image create "$name-$version" \
      --file             "$filepath" \
      --disk-format       qcow2 \
      --container-format  bare \
      --property          os_distro="$name" \
      --property          os_version="$version" \
      --public
done

# check
openstack image list --long
```

---
# Authentication / Authorization
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)
```bash
PRJ_NAME=workshop
USR_NAME=workshop
USR_PASS=workshop

# create project
openstack project create                                 $PRJ_NAME
openstack quota set --instances 32 --cores 64            $PRJ_NAME

# create user
openstack user create --password $USR_PASS --project $PRJ_NAME $USR_NAME

# create permissions for the user
openstack role add    --user $USR_NAME     --project $PRJ_NAME member

# check
openstack role assignment list --name
openstack quota show $PRJ_NAME
```

---
# Networking
![bg right:65% 80%](https://firstcloud.pl/assets/images/posts/2025/4-tenant-provider-net.svg)
* OpenVSWitch
* SDN-Networks:
  * flat
  * vxlan
  * vlan
* Routers
* Network Namespaces
* FloatingIPs
* LoadBalancers

---
# Networking - external networks
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)

```bash
# Create external network (vlan backed)                                     📋
EXT_NET_VLAN=3010
EXT_NET_NAME="shared${EXT_NET_VLAN}"
EXT_NET_CIDR='10.30.10.0/24'
EXT_NET_RANGE='start=10.30.10.192,end=10.30.10.254'
EXT_NET_GATEWAY='10.30.10.1'


openstack network create       $EXT_NET_NAME  \
   --provider-physical-network physnet3       \
   --provider-network-type     vlan           \
   --provider-segment          $EXT_NET_VLAN  \
   --external

openstack subnet create  $EXT_NET_NAME-subnet \
    --allocation-pool    ${EXT_NET_RANGE}     \
    --network            $EXT_NET_NAME        \
    --subnet-range       ${EXT_NET_CIDR}      \
    --gateway            ${EXT_NET_GATEWAY}   \
    --no-dhcp
```

---
# Networking - tenant networks
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)

```bash
# Create external network (vxlan backed)                                    📋
PRJ_NAME=workshop
openstack network create workshop-net        \
  --project $PRJ_NAME                        \
  --provider-network-type vxlan

openstack subnet create workshop-subnet \
  --project $PRJ_NAME                   \
  --subnet-range 10.10.10.0/24          \
  --network workshop-net                \
  --gateway 10.10.10.1

openstack router create workshop-router --project $PRJ_NAME
openstack router add subnet workshop-router workshop-subnet
openstack router set --external-gateway shared3010 workshop-router

# Create a new instance
IMAGE_NAME=ubuntu-24.04
# IMAGE_NAME=alma-10.1
# IMAGE_NAME=rocky-10.1
# IMAGE_NAME=debina-13
openstack server create     \
  --project  $PRJ_NAME      \
  --image   ${IMAGE_NAME}   \
  --flavor   m1.medium      \
  --key-name mykey          \
  --nic net-id=workshop-net \
  vm0
```


---
# Block Devices
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)
* Volumes
* Snapshots
* Images

---
# User Config (Cloud-Init)
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)

---
# Resource Segregation
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)

---
# Host Aggregates
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)

---
# Availalbility Zones
![bg right:30% 50%](https://www.svgrepo.com/show/354145/openstack-icon.svg)
