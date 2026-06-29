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


# Architecture

---
# OpenStack Distrubutions
[Catalog](https://www.openstack.org/marketplace/distros/)


- [OSISM](https://www.openstack.org/marketplace/distros/distribution/osism/osism-distro)
- [Mirantis](https://www.openstack.org/marketplace/distros/distribution/mirantis/mirantis-openstack-for-kubernetes)
- [Canonical](https://www.openstack.org/marketplace/distros/distribution/canonical/canonical-openstack)
- [RedHat](https://docs.redhat.com/en/documentation/red_hat_openstack_services_on_openshift/18.0/html/planning_your_deployment/assembly_red-hat-openstack-services-on-openshift-overview#con_alternate-topo-rhoso_rhoso-overview)
- [FishOS](https://www.openstack.org/marketplace/distros/distribution/sardina-systems/fishos)



---
# OpenStack
![w:900 ](https://www.openstack.org/static/000588f8b89d94da80eba6101f72ff7a/openstack-map-v20240401.png)

---
# Workshop Environment
![ ](assets/archtecture/openstack-environment.svg)

---
# Architecture - Ceph
![](https://www.ironnetworks.com/sites/default/files/products/CEPH-graphic.png)

---
# Workshop Environment
![ ](assets/archtecture/ceph-environment.svg)


---
# Integration - OpenStack and Ceph

![w:700](https://www.redhat.com/rhdc/managed-files/sysadmin/2021-08/Ceph-storage-cluster-%28RADOS%29.png)


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
- [cephadm (official)](https://docs.ceph.com/en/reef/cephadm/install/#cephadm-deploying-new-cluster)
- [rook](https://rook.io/)

<hr/>

- [ceph-ansible](https://docs.ceph.com/projects/ceph-ansible/en/latest/)
- [ceph-salt](https://github.com/ceph/ceph-salt)
- [ceph-deploy (deprecated)](https://docs.ceph.com/projects/ceph-deploy/en/latest/)
- [juju](jaas.ai/ceph-mon)
- [manually](https://docs.ceph.com/en/reef/install/index_manual/#install-manual)

---
# OpenStack Environment

<div class="mermaid">
---
config:
 layout: fixed
---
flowchart TB
subgraph Controllers["Controllers"]
   direction LR
       C1["controller01"]
       C2["controller02"]
       C3["controller03"]
end
subgraph NetworkNodes["NetworkNodes"]
   direction LR
       N1["network01"]
       N2["network02"]
       N3["network03"]
end
subgraph ComputeNodes["ComputeNodes"]
   direction LR
       CMP1["compute01"]
       CMP2["compute02"]
       CMP3["compute03"]
end
NetworkNodes --> Controllers
ComputeNodes --> Controllers
C1 <-.-> C2
C2 <-.-> C3
C3 <-.-> C1
N1 <-.-> N2
N2 <-.-> N3
N3 <-.-> N1
</div>

---
# Node Groups
- Deployment Node
- Infrastructure: registry, proxy, dns, recorder
- OpenStack Nodes
- Ceph Nodes

---
# Infrastructure
<div class="mermaid">
graph LR
    internet[Internet <img src="https://www.svgrepo.com/show/243037/clouds-cloud.svg" width="60"/>]
    subgraph Infrastructure
        direction TB
        registry("Registry\n(Harbor)")
        dns("DNS\n(dnsmasq)")
        proxy("Proxy\n(squid)")
        recorder("Recorder\n(ansible/ara)")
    end
    subgraph Environment
        direction TB
        os(OpenStack)
        ceph(Ceph)
        deploy("Deployment")
    end
    %% Connections
    dns --> internet
    registry --> internet
    proxy --> internet
    os --> registry
    os --> dns
    ceph --> registry
    ceph --> dns
    deploy --> proxy
    deploy --> dns
    deploy --> recorder
    %%Environment --> Infrastructure
    %%registry --> os
</div>

---
# Deployment Node
* python virtual envs
* kolla-ansible
* cephadm

---
# Baremetal Node and VMs on it
* Deployment VM
* Infra VMs: 4
* OpenStack VMs: 3xController, 3xNetwrok, 3(+)xCompute
* Ceph VMs: 3xMons, 3(+) OSDs

---
# Air-Gapped Environment
![width:600](https://upload.wikimedia.org/wikipedia/commons/d/da/Air_gap_network.png)
