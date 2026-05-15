---
title:       Ceph
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

# Ceph
[//]: # (https://dev.to/prianshu-dev/ceph-explained-the-distributed-storage-backbone-powering-modern-infrastructure-44nc) 
[//]: # (https://docs.ceph.com/en/latest/architecture/)
[//]: # (https://fabreur.medium.com/ceph-an-overview-e971c00ded93)
[//]: # (https://documentation.suse.com/de-de/ses/7.1/html/ses-all/cha-storage-about.html)
[//]: # (https://ubuntu.com/ceph/what-is-ceph)
[//]: # (https://docs.redhat.com/en/documentation/red_hat_ceph_storage/5/html-single/architecture_guide/index)

---
# Archtecture
![image](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F2au17xy0419hsx797qe0.png)

---
# Archtecture
![image](https://media2.dev.to/dynamic/image/width=800%2Cheight=%2Cfit=scale-down%2Cgravity=auto%2Cformat=auto/https%3A%2F%2Fdev-to-uploads.s3.amazonaws.com%2Fuploads%2Farticles%2F1c42zy6mdke05ii4zgay.webp)

---
# Deploy Ceph with Cephadm

```bash
##############################################################################
# preps
git clone https://github.com/codecap/openstack-workshop.git

ln -s ~/openstack-workshop/cephadm       ~/ceph
ln -s ~/openstack-workshop/kolla-ansible ~/openstack

cd openstack-workshop
./scripts/print-ssh-config  >> ~/.ssh/config
```

---
# Monitoring

---
# Praxis

---
# Pools

---
# RBD Volumes

---
# Filesystems

---
# RadosGW / S3

---
# Clients

---
# Operations

---
# Replace an OSD

---
# Replace an OSD Node

---
# Replance a Controller node
