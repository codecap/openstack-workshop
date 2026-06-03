#!/usr/bin/env bash
HARBOR_USER="admin"
HARBOR_PASS="Harbor12345"
HARBOR_VERSION="2.10.0"

# Download
wget https://github.com/goharbor/harbor/releases/download/v${HARBOR_VERSION}/harbor-online-installer-v${HARBOR_VERSION}.tgz
tar xzvf harbor-online-installer-v${HARBOR_VERSION}.tgz

# Configure
cd harbor
cp harbor.yml.tmpl harbor.yml

# set admin password
sed -i harbor.yml -e "s/^harbor_admin_password:.*/harbor_admin_password: $HARBOR_PASS/"
# change the hostname
sed -i harbor.yml -e "s/^hostname:.*/hostname: registry.wrx.sckt.net/"
# switch off https
sed -i harbor.yml '/^https:/,/private_key:/ s/^/#/'

# Install
./install.sh ; sleep 5;


# Setupt Proxy Repository
curl -sS -u "$HARBOR_USER:$HARBOR_PASS" -X POST "http://localhost/api/v2.0/registries" \
 -H "Content-Type: application/json" \
 -d '{
   "name": "quay-upstream",
   "type": "quay",
   "url": "https://quay.io"
 }'

curl -sS -u "$HARBOR_USER:$HARBOR_PASS" -X POST "http://localhost/api/v2.0/projects" \
 -H "Content-Type: application/json" \
 -d '{
   "project_name": "quay",
   "public": true,
   "metadata": {
     "public": "true",
     "proxy_cache": "true"
   },
   "registry_id": 1
 }'
