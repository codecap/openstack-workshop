---
title:       Architecture
description: OpenStack & Ceph
author:      Vladislav Nazarenko (vnazarenko@📯socket.de)
keywords:    openstack,ceph,workshops,operations,troubleshoouting
url:         
image:
transition: cover
backgroundImage: url(https://raw.githubusercontent.com/codecap/openstack-workshop/refs/heads/main/assets/background.jpg)
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


# Architecture
<div class="mermaid">
graph LR
    A[User] --> B[OpenStack]
    B --> C[Ceph]
</div>

---
# OpenStack Distrubutions

[//]: # (TODO: https://www.openstack.org/marketplace/distros/)

---
# Architecture - OpenStack


---
# Architecture - Ceph


---
# Integration - OpenStack and Ceph


---
# OpenStack Deployment Approaches
- openstack-ansible
- kolla-ansible
- OpenStack on OpenShift
- OpenStack-Helm
- OSISM
- YAOOK
...

---
# Ceph Deployment Aproaches
- cephadm (official)
- ceph-ansible
- rook
...

---
# OpenStack Environment

<div class="mermaid">
architecture-beta
    group api(cloud)[API]
    service db(database)[Database] in api
    service disk1(disk)[Storage] in api
    service disk2(disk)[Storage] in api
    service server(server)[Server] in api
    db:L -- R:server
    disk1:T -- B:server
    disk2:T -- B:db
</div>

---
# Ceph Environment

<div class="mermaid">
architecture-beta
    group api(cloud)[API]
    service db(database)[Database] in api
    service server(server)[Server] in api
    service disk1(disk)[Storage] in api
    service disk2(disk)[Storage] in api
    group cephosd01(server)[cephosd01]
    service nvme11(disk)[nvme01] in cephosd01
    service nvme12(disk)[nvme02] in cephosd01
    service nvme13(disk)[nvme03] in cephosd01
    group cephosd02(server)[cephosd02]
    service nvme21(disk)[nvme01] in cephosd02
    service nvme22(disk)[nvme02] in cephosd02
    service nvme23(disk)[nvme03] in cephosd02
    group cephosd03(server)[cephosd03]
    service nvme31(disk)[nvme01] in cephosd03
    service nvme32(disk)[nvme02] in cephosd03
    service nvme33(disk)[nvme03] in cephosd03
    db:L -- R:server
    disk1:T -- B:server
    disk2:T -- B:db    
</div>


---
# Infrastructure
[//]: # (registry:)
[//]: # (dns:)
[//]: # (proxy:)
[//]: # (reccorder:)

---
# Deployment Node
[//]: # (kolla-ansible:)
[//]: # (cephadm:)
[//]: # (ansible:)

---
# Baremetal Node and VMs on it
[//]: # (kolla-ansible)
[//]: # (cephadm)
[//]: # (ansible)

---
# Node Groups
- Deployment node
- Infrastructure: registry, proxy, dns
- OpenStack Nodes
- Ceph Nodes

---
# Air-Gapped Environment
