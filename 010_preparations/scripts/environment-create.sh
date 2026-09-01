#!/usr/bin/env bash

##############################################################################
# vars
WRX_INFRA_NODES_GR1="dns|proxy|registry"
WRX_INFRA_NODES_GR2="deployment|recorder"

##############################################################################
# Infra nodes
print-create-env-commands  | grep -E "$WRX_INFRA_NODES_GR1" | bash

##############################################################################
# Deployment nodes

sleep 120
print-create-env-commands  | grep -E "$WRX_INFRA_NODES_GR2" | bash

# copy the key to the deployment node, so we can access every node from there
scp /root/.ssh/id_rsa* deployment:/home/deploy/.ssh

##############################################################################
# Environment nodes
print-create-env-commands  | grep -v -E "$WRX_INFRA_NODES_GR1|$WRX_INFRA_NODES_GR2" | bash
