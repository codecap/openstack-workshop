---
title:       Preparations
description: OpenStack & Ceph
author:      Vladislav Nazarenko (vnazarenko@📯socket.de)
keywords:    openstack,ceph,workshops,operations,troubleshoouting
url:         
image:
transition: cover
backgroundImage: url(https://raw.githubusercontent.com/codecap/openstack-workshop/refs/heads/main/assets/background.jpg)
paginate: true
footer: "[infraguide.org](https://infraguide.org) | Questions or need a guided workshop? → ping@socket.de"
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

// Register the "logos" pack (contains AWS, GCP, tech logos)
// https://icones.js.org/collection/logos
// https://icones.js.org/collection/mdi
  mermaid.registerIconPacks([
    {
      name: 'logos:laptop',
      loader: () => fetch('https://unpkg.com/@iconify-json/logos@1/icons.json').then(res => res.json()),
    },
    {
      name: 'mdi',
      loader: () => fetch('https://unpkg.com/@iconify-json/mdi@1/icons.json').then(res => res.json()),
    }
  ]);

</script>


# Preparations

---
# Deployment

<div class="mermaid">
architecture-beta
    group deployment[Deployment]
      service deploy(mdi:laptop)[deploy] in deployment
    group env[Environment]
      group os[OpenStack] in env
        service server_os(mdi:server) in os
      group ceph[Ceph]    in env
        service server_ceph(mdi:server) in ceph
    %% connections
    deploy{group}:R -- L:server_os{group}
    deploy{group}:R -- L:server_ceph{group}
</div>

---
# Deployment Models

- **Baremetal** - all servers listed are baremetal machines, at least a single
switch to interconnect and a instance for deployment (VM, laptop, a small
baremetal machine)
- **Hyperconverged** - at least a singel baremetal node, to create all listed
servers as VMs and additianally an instance for deployment.
- **Hybrid** - some baremetal nodes to virtualize servers (controllers, network, inrastructure) and some to use to deliver performance (compute, ceph osd nodes)

**Baremetal** and **Hybrid** aproaches can be used for production environments


---
# Hyperconverged Environments
**Advantages**:
- simple and fast
- single baremetal node needed
- all listed servers backed by VMs
- all listed networks backed by OpenVSwitch / Linux Bridges
- no physical switch needed

**Disadvantages**:
- less insights into networking
- less performance possible


---
# Aproaches to create hyperconverged environment
we will need at least a single baremetal node with either:
- KVM | libvirt
- singlenode openstack environment
- singlenode proxmox environment
- singlenode incus environment
...

---
# Proxmox
![bg right:40% 50%](https://www.svgrepo.com/show/331552/proxmox.svg)

```bash
# Install post-pve-install.sh                                               📋
bash -c "$(curl -fsSL https://raw.githubusercontent.com/community-scripts/ProxmoxVE/main/tools/pve/post-pve-install.sh)"

# Prepare a new template for VMs
# https://www.croit.io/blog/how-to-use-cloud-images-for-faster-vm-deployment-in-proxmox-ve

TEMPL_ID=9000

wget -O /tmp/noble-server-cloudimg-amd64.img \
https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img

qm create $TEMPL_ID \
--name ubuntu-2404-cloud-init \
--description "Ubuntu 24.04 Cloud Init template" \
--ostype l26 \
--cpu cputype=host \
--cores 1 \
--sockets 1 \
--memory 2048 \
--scsihw virtio-scsi-pci \
--net0 virtio,bridge=vmbr0

qm importdisk $TEMPL_ID /tmp/noble-server-cloudimg-amd64.img local-lvm

qm set $TEMPL_ID --scsi0 local-lvm:vm-$TEMPL_ID-disk-0
qm set $TEMPL_ID--boot c --bootdisk scsi0

qm set $TEMPL_ID --serial0 socket --vga serial0

qm set $TEMPL_ID --ide2 local-lvm:cloudinit

qm set $TEMPL_ID --ipconfig0 ip=dhcp
qm cloudinit update $TEMPL_ID

qm template $TEMPL_ID

#Install Packages
apt install -y  \
 bind9-dnsutils \
 curl           \
 git            \
 htop           \
 jq             \
 tcpdump        \
 tmux           \
 tmuxp          \
 crudini        \
 vim            \
 yq
```

---
# Proxmox
![bg right:60% 35%](https://www.svgrepo.com/show/331552/proxmox.svg)
```bash
# Create Bridges                                                            📋
cat > /etc/network/interfaces.d/wrx <<EOF
auto cpln01
iface cpln01 inet manual
        bridge-ports none
        bridge-stp off
        bridge-fd 0
auto dpln0
iface dpln0 inet manual
        bridge-ports none
        bridge-stp off
        bridge-fd 0
auto brmgmt0
iface brmgmt0 inet static
        address 10.14.0.8/24
        bridge-ports none
        bridge-stp off
        bridge-fd 0
auto brsrvc0
iface brsrvc0 inet static
        address 10.34.10.8/24
        bridge-ports none
        bridge-stp off
        bridge-fd 0
auto brcpln0
iface brcpln0 inet manual
        bridge-ports none
        bridge-stp off
        bridge-fd 0
auto brdpln0
iface brdpln0 inet manual
        bridge-ports none
        bridge-stp off
        bridge-fd 0
auto brlmgt0
iface brlmgt0 inet manual
        bridge-ports none
        bridge-stp off
        bridge-fd 0
auto brxtrn0
iface brxtrn0 inet manual
        bridge-ports none
        bridge-stp off
        bridge-fd 0
auto brstrg0
iface brstrg0 inet manual
        bridge-ports none
        bridge-stp off
        bridge-fd 0
auto brstrg1
iface brstrg1 inet manual
        bridge-ports none
        bridge-stp off
        bridge-fd 0
# vimbr0 is used for public0
EOF

systemctl restart networking.service
brctl show
```

---
# Let's GO!
![bg right:40% 30%](https://www.svgrepo.com/show/282117/tools-hammer.svg)


```bash
git clone https://github.com/codecap/openstack-workshop.git

cd openstack-workshop
./scripts/print-ssh-config  >> ~/.ssh/config
```

---
# Configuration
![bg right:45% 25%](https://api.iconify.design/file-icons:config.svg)
[Link](https://github.com/codecap/openstack-workshop/blob/main/conf/env.yaml)
```yaml
resolve_conf:
  nameservers:
    - 10.14.0.10
  searchdomains: []
##############################################################################
network_conf:
  public:
    iface:       pblc0
    bridgename:  vimbr0
    addr:        10.10.61.0/24
    netmask:     255.255.255.0
    gateway:     10.10.61.1/24
    nameservers: [10.10.11.99]
  management:
    iface:   mgmt0
    addr:    10.14.0.0/24
  services:
    iface:   srvc0
    addr:    10.34.10.0/24
...
##############################################################################
server_conf:
  - hostname:    "dns"
...
```

---
# Scripts

<style scoped>
table, thead, tbody, tr, th, td {
  background-color: transparent !important;
  border: none !important;
}
td:first-child {
  white-space: nowrap !important;
  vertical-align: top; 
}
</style>

| | |
| :--- | :--- |
| ⚙️ **create-vm**    | creates a new VM defined by parameters                    |
| ⚙️ **print-create-env-commands**  | reads `conf/env.yaml` file and prints the commands required to create the full environment  |
| ⚙️ **print-destroy-env-commands** | reads `conf/env.yaml` file, queries the current state, and prints the commands required to destroy the entire environment |


```bash
create-vm --id 10 --name dns.wrx.sckt.net --cpu 1 --ram 4096 --disks '[8]' --netconf '
     {
       "mgmt0": {"ip": "10.14.0.10/24",  "macaddr": "bc:24:11:99:04:0a"},
       "srvc0": {"ip": "10.34.10.10/24", "macaddr": "bc:24:11:99:06:0a"}
     }'
```
---
# How to use scripts
![bg right:45% 25%](https://api.iconify.design/file-icons:easybuild.svg)

```bash
# create a new environment
print-create-env-commands | bash

#  destroy whole environment
print-destroy-env-commands | bash

# if you need to rebuild only a set or a single server, you can use grep with a matching filter
print-destroy-env-commands | grep <NODE_FILTER> | bash
print-create-env-commands  | grep <NODE_FILTER> | bash
```

---
# Create a workshop environment
![bg right:40% 30%](https://www.svgrepo.com/show/282117/tools-hammer.svg)

```bash
BASE_PATH=https://raw.githack.com/codecap/openstack-workshop/main

INFRA_NODES="dns|proxy|registry"
DEPLOY_NODES="deployment|recorder"

# Infra Nodes
print-create-env-commands  | grep -E "$INFRA_NODES" | bash
ssh -t dns      "sudo -i bash -c 'curl -L $BASE_PATH/scripts/infra/dns.sh      | bash'"
ssh -t proxy    "sudo -i bash -c 'curl -L $BASE_PATH/scripts/infra/proxy.sh    | bash'"
ssh -t registry "sudo -i bash -c 'curl -L $BASE_PATH/scripts/infra/registry.sh | bash'"

# Deployment Nodes
print-create-env-commands  | grep -E "$DEPLOY_NODES" | bash
ssh -t recorder "sudo -i bash -c 'curl -L $BASE_PATH/scripts/infra/recorder.sh | bash'"

# Environment Nodes
print-create-env-commands  | grep -E "$INFRA_NODES|$DEPLOY_NODES"   | bash

# copy the ssh keys to deployment, so the node can be used as jump host
scp /root/.ssh/id_rsa* deployment:/home/deploy/.ssh


# FIXME: disks on cephosd nodes 100Gb should be available for OSDs 

```

---
# Configure a Tunnel
## To access environment
![bg right:40% 30%](https://www.svgrepo.com/show/375447/identity-aware-proxy.svg)

```bash
* generate a new eddsa key with **PuTTYgen** an save it on your system
* put the public key in ~/.ssh/authorized_key on:
  * hypervisor (root)
  * deployment (deploy)

* Start PuTTy. Go to Connection -> SSH -> Auth -> Credentials. Load the Pricate Key
* Go to Connection -> Data. Put "root" for "Auto-login usernmae"
* Go to Session. Put the IP of your hypervisor,
* Put the name for the session - "hypervisor". Save.
* Press "Open" button, a new session should be opened

* Create a new session with PuTTY
  * Put 10.14.0.24 into "Host Name" Field
  * Under Connection -> Data, put "deploy" for "Auto-login usernmae"
  * Under Connection -> SSH -> Auth -> Credentials load the private key
* Go to Connection -> SSH -> Tunnels
  * Chose Dynamic
  * Source Port: 8888
  * Press "Add" button
* Go to Connection -> Proxy
  * set type to "SSH to proxy and port forward"
  * set Proxy hostname to "hypervisor"
  * set port to 22
* Go to Session
  * put deployment to "Saved Sessions"
  * press "save
  * press open
```

---
# Configure Proxy
![bg right:40% 30%](https://www.svgrepo.com/show/375447/identity-aware-proxy.svg)
```bash
* Open Firefoxx
* Go to settings
* Search for "proxy"
* Choose "Manual Configuration" 
* Put "127.0.0.1" in Socks-Host Field, Port: 8888
* Choose SOCKS v5
```

---
# SSH config
![bg right:40% 30%](https://www.svgrepo.com/show/282117/tools-hammer.svg)

```bash
# On deployment node create SSH Config to access workshop environemnt       📋
cat >> ~/.ssh/config <<EOF
Host hypervisor hypervisor.wrx.sckt.net
  User root

Host *.mgmt *.mgmt.wrx.sckt.net *.wrx.sckt.net
  User  deploy

Host *
  User                  deploy
  StrictHostKeyChecking no
  UserKnownHostsFile    /dev/null
EOF
```

---
# Some Common Configs
![bg right:40% 30%](https://www.svgrepo.com/show/282117/tools-hammer.svg)
```bash
# On deployment node check out the repository                               📋
cd ~
git clone https://github.com/codecap/openstack-workshop.git

ln -s ~/openstack-workshop/kolla-ansible openstack
ln -s ~/openstack-workshop/cephadm       ceph

# Install and configure tmuxp
sudo apt install pipx
pipx install tmuxp

cat >> ~/.profile <<EOF

alias wrx-stack='tmuxp load -y ~/openstack-workshop/conf/tmuxp.yaml'
EOF
```
