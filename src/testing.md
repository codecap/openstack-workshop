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


# Testing

--- 
# Why?
- Changes
- Regression
- Impact of outside events (Network, Storage)
- Monitoring (over time)
- Confifance (I have a working environment)
- Recognition of patential problems (in advance)

---
# Challenges
- my specific configuration
- my specific implementation / deployment / infra
- networking
- changes outside of my environment ( BGP, Storage, Object Storage, DNS)

---
# Tempest

---
# Ansible / Terraform

---
# Scripts

https://github.com/SovereignCloudStack/openstack-health-monitor
