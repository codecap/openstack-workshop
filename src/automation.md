---
title:       Automation
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

# Automation

---
# Ansible
```bash
python3 -m venv ~/venv/ansible
source  ~/venv/ansible/bin/activate


git clone https://github.com/codecap/openstack-workshop.git
cd  openstack-workshop/ansible
pip install -U pip
pip install -r requirenments.txt

ansible-galaxy collection install -r requirenments.yaml --force
```

---
# Credentials
```bash
cat > ~/automation-openrc.sh<<"EOF"

# Clear any old environment that may conflict.
for key in $( set | awk '{FS="="}  /^OS_/ {print $1}' ); do unset $key ; done

export OS_ENDPOINT_TYPE=internalURL
export OS_REGION_NAME=RegionOne
export OS_INTERFACE=internal
export OS_AUTH_PLUGIN=password
export OS_AUTH_URL=http://int.os.wrx.sckt.net:5000
export OS_PROJECT_DOMAIN_NAME=Default
export OS_TENANT_NAME=automation
export OS_USERNAME=automation
export OS_USER_DOMAIN_NAME=Default
export OS_PROJECT_NAME=automation
export OS_PASSWORD=automation
export OS_IDENTITY_API_VERSION=3
EOF

cat > clouds.yml <<EOF
---
clouds:
  wrx:
    auth:
      auth_url:            "http://int.os.wrx.sckt.net:5000/v3"
      username:            "automation"
      password:            "automation"
      project_name:        "automation"
      user_domain_name:    "Default"
      project_domain_name: "Default"
    region_name: "RegionOne"
    interface: "internal"
    identity_api_version: 3
EOF

```

---
# Run
```bash

ansible-playbook playbooks/create-project.yml

ansible-playbook playbooks/create-infra.yml

ansible-playbook playbooks/destroy-infra.yml


```



---
# Terraform


```bash
# Preparations

curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt-get update && sudo apt-get install terraform

terraform --version

cd automation/terraform
terraform init

ls -la
cat .terraform.lock.hcl
terraform providers 




TF_VAR_os_password=$OS_PASSWORD terraform plan

TF_VAR_os_password=$OS_PASSWORD terraform apply -auto-approve


```



---
# Testinfra

```bash

py.test  --hosts=ssh://ubuntu@<SERVER_IP> server.py -v
```
