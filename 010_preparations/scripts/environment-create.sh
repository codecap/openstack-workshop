#!/usr/bin/env bash

##############################################################################
# vars
WRX_RAW_BASE_PATH=https://raw.githack.com/codecap/openstack-workshop/refs/heads/main
WRX_INFRA_NODES="dns|proxy|registry"
WRX_DEPLOY_NODES="deployment|recorder"
CONF_SCRIPT=$WRX_RAW_BASE_PATH/010_preparations/scripts/proxmox-template.sh

##############################################################################
# Install a template VM
curl -sS -L $CONF_SCRIPT | bash

##############################################################################
# Infra nodes
print-create-env-commands  | grep -E "$WRX_INFRA_NODES" | bash
echo 'curl -sS -L $WRX_RAW_BASE_PATH/scripts/infra/dns.sh       | bash' | ssh -t dns      'sudo -i'
echo 'curl -sS -L $WRX_RAW_BASE_PATH/scripts/infra/proxy.sh     | bash' | ssh -t proxy    'sudo -i'
echo 'curl -sS -L $WRX_RAW_BASE_PATH/scripts/infra/registry.sh  | bash' | ssh -t registry 'sudo -i'

##############################################################################
# Deployment nodes
print-create-env-commands  | grep -E "$WRX_DEPLOY_NODES" | bash
echo 'curl -sS --proxy $WRX_PROXY -L $WRX_RAW_BASE_PATH/scripts/infra/recorder.sh  | bash' | ssh -t recorder 'sudo -i'

scp /root/.ssh/id_rsa* deployment:/home/deploy/.ssh

##############################################################################
# Environment nodes
print-create-env-commands  | grep -v -E "$WRX_INFRA_NODES|$WRX_DEPLOY_NODES" | bash
