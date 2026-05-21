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

![ bg right:65% 80%](https://docs.openstack.org/contributors/es_MX/_images/map-of-OpenStack-projects.png)
https://cdn.jsdelivr.net/gh/homarr-labs/dashboard-icons/svg/openstack.svg
Try
bg split [left|right]: This tells Marp, "Put this image on one half of the screen, and push all the text to the other half."

bg vertical: This tells Marp, "If there are multiple background images on this slide, stack them top-to-bottom instead of side-by-side."

Combining them (bg split right vertical): This tells Marp to dedicate the right half of the slide to images, and if you provide more than one image, stack them vertically within that right half.

💡 Note: Always make sure your first image contains the full instruction (e.g., bg split left vertical), and any following images just need the standard bg tag to inherit that layout.

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
