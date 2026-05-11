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

---
# Architecture

---
# Deploy OpenStack with kolla-ansible

---
# Service Overview

---
# Praxis
- create a project / user
- create networks
- create router
- create vms
...
- live migraions

---
# Operations

---
# Replace a Compute Node

---
# Replace a Network Node

---
# Replace a Controller Node

---
# High Availbility

---
# Debugging

---
# Backup and Recovery

---
# Upgrades

---
# Monitoring / Logging
* Ceilometer / Gnochi
* Modernes Monitoring
* Central Loggin

---
# Networking
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
# Block Devices
* Volumes
* Snapshots
* Images

---
# Images

---
# User Config (Cloud-Init)

---
# Resource Segregation

---
# Host Aggregates

---
# Availalbility Zones
