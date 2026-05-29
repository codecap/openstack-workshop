---
title:       OpenStack Workshop
description: OpenStack & Ceph
author:      Vladislav Nazarenko (vnazarenko@📯socket.de)
keywords:    openstack,ceph,workshops,operations,troubleshoouting
url:
image:
backgroundImage: url(https://raw.githubusercontent.com/codecap/openstack-workshop/refs/heads/main/assets/background.jpg)
transition: cover
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
</script>

# OpenStack Workshop


---
# Targets
- Deployment
- Operations
- Networking
- Security
- Monitoring
- Troubleshooting
- Automation
- Testing

---
# Content
1. [Intro](intro.html)
1. [Architecture](architecture.html)
1. [Preparations](preparations.html)
1. [Ceph](ceph.html)
1. [OpenStack](openstack.html)
1. [Automation](automation.html)
1. [Testing](testing.html)


---
# Links

- [Harbor - Registry](http://registry.wrx.sckt.net/)
- [Ara - Recorder](http://registry.wrx.sckt.net/)
- [Ceph - Dashboard](https://cephmon01.strg.wrx.sckt.net:8443)
- [Ceph - Grafana/Monitoring](https://cephgra01.strg.wrx.sckt.net:3000)
- [Ceph - Prometheus/Monitroing](https://cephgra01.strg.wrx.sckt.net:9095)
- [Ceph - Alertmanager](https://cephgra01.strg.wrx.sckt.net:9093)
- [OpenStack - Hirizon/Dashboard](http://int.os.wrx.sckt.net)
- [OpenStack - Skyline/Dashboard](http://int.os.wrx.sckt.net:9999)
- [OpenStack - Grafana/Monitoring](http://int.os.wrx.sckt.net:3000)
- [OpenStack - Prometheus/Monitoring](http://int.os.wrx.sckt.net:9091)
- [OpenStack - Alertmanager](http://int.os.wrx.sckt.net:9093)

---
# Author

Vladislav Nazarenko · [socket.de/vna](https://socket.de/vna) · [LinkedIn](https://www.linkedin.com/in/vladislav-nazarenko/)

Found an error or want to contribute? Open a PR on [GitHub](https://github.com/codecap/openstack-workshop)
