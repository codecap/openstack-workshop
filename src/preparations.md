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
# Let's GO!
![bg right:30% 50%](https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/ceph.svg)

```bash
git clone https://github.com/codecap/openstack-workshop.git

ln -s ~/openstack-workshop/cephadm       ~/ceph
ln -s ~/openstack-workshop/kolla-ansible ~/openstack

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
       "mgmt0": {"ip": "10.14.0.10/24", "macaddr": "bc:24:11:99:04:0a"},
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

```

---
# Prepare a working environment
![bg right:25% 25%](https://api.iconify.design/file-icons:easybuild.svg)
- single proxmox node
- run post-pve-install.sh
- create bridges accoding `network_conf`
- install ubuntu image, prepare a new template for VMS
- create VMs for the workshop
```bash
print-create-env-commands | bash
```
- test created environment
```bash
# TBD
```

---
# Prepare proxy to access environment
[//]: # ( FIXME
putty generate a new key
create a config for hypervisor
create a config for deployment host
configure firefox to use socks5 proxy
)

---
# Prepare ssh config on deplomyent node
```bash
cat >> ~/.ssh/config <<EOF
Host *.mgmt.wrx.sckt.net
  User                  deploy
  StrictHostKeyChecking no
  UserKnownHostsFile    /dev/null
EOF
```
