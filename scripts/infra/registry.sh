#!/usr/bin/env bash
HARBOR_USER=admin
HARBOR_PASS=Harbor12345
apt update; apt install docker-compose-v2 -y
# Install
wget https://github.com/goharbor/harbor/releases/download/v2.10.0/harbor-online-installer-v2.10.0.tgz
tar xzvf harbor-online-installer-v2.10.0.tgz
cd harbor
cp harbor.yml.tmpl harbor.yml
# change the hostname
sed -i harbor.yml -e "s/^hostname:.*/hostname: registry.wrx.sckt.net"
# switch off https
sed -i '/^https:/,/private_key:/ s/^/#/' harbor.yml
./install.sh ; sleep 5;


# Set proxy in
#  * common/config/core/env
#  * common/config/jobservice/env
# HTTP_PROXY=https://proxy.wrx.sckt.net:3128
# HTTPS_PROXY=https://proxy.wrx.sckt.net:3128
# NO_PROXY=127.0.0.1,localhost,.wrx.sckt.net,harbor-core,harbor-db,harbor-jobservice,registry,registryctl,chartmuseum,trivy,redis


# # Configure
# curl -sS -u "$HARBOR_USER:$HARBOR_PASS" -X POST "http://localhost/api/v2.0/registries" \
#   -H "Content-Type: application/json" \
#   -d '{
#     "name": "quay-upstream",
#     "type": "quay",
#     "url": "https://quay.io"
#   }'
# curl -sS -u "$HARBOR_USER:$HARBOR_PASS" -X POST "http://localhost/api/v2.0/projects" \
#   -H "Content-Type: application/json" \
#   -d '{
#     "project_name": "quay",
#     "public": true,
#     "metadata": {
#       "public": "true",
#       "proxy_cache": "true"
#     },
#     "registry_id": 6
#   }'
