#!/bin/bash
##############################################################################
# config

ID_START_FROM=1000
TEMPLATE_ID=9000
STORAGE="local-lvm"
NCARD_MODEL="virtio"
##############################################################################
# parameters

NAMESERVER="10.10.11.99"
SEARCHDOMAIN=

##############################################################################
# functions
function print_usage
{
cat <<EOF
$(basename $0) --id 10 --name myname [ARGs]
    --id       - server id
    --name     - server name
    --cpu      - number of CPUs
    --ram      - RAM (Gb)
    --disks    - disks to create and attach (json)
    --netconf  - network configuration for the interfaces to attach (json)
EOF
}


##############################################################################
# vars
NAME=""
CPU="1"
RAM="2048"
DISKS_JSON="[]"
NETCONF_JSON="{}"

# 1. Parse Arguments
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --id)       ID="$2";            shift 2 ;;
        --name)     NAME="$2";          shift 2 ;;
        --cpu)      CPU="$2";           shift 2 ;;
        --ram)      RAM="$2";           shift 2 ;;
        --disks)    DISKS_JSON="$2";    shift 2 ;;
        --netconf)  NETCONF_JSON="$2";  shift 2 ;;
        *) echo "Unknown parameter: $1"; exit 1 ;;
    esac
done

VMID=$(($ID_START_FROM+ID))

##############################################################################
# checks

if [ -z "$ID" ]
then
    print_usage
    exit
fi

if [ -z "$HOSTNAME" ]
then
    print_usage
    exit
fi

##############################################################################
# go

qm clone $TEMPLATE_ID $VMID --name $NAME --full

qm set $VMID --ciuser deploy

# network
while IFS=$'\t' read -r NET_NAME IP GW MTU; do

    NEXT_ID=0
    while qm config "$VMID" | grep -q "net$NEXT_ID:"; do
        ((NEXT_ID++))
    done


    qm set $VMID --net$NEXT_ID      "$NCARD_MODEL,bridge=br$NET_NAME"
    qm set $VMID --ipconfig$NEXT_ID "ip=${IP}${GW:+,gw=$GW}${MTU:+,mtu=$MTU}"
done < <(echo "$NETCONF_JSON" | jq -r 'to_entries[] | "\(.key)\t\(.value.ip // "")\t\(.value.gw // "")\t\(.value.mtu // "")"')


if [ ! -z "$NAMESERVER" ]
then
  qm set $VMID --nameserver "$NAMESERVER"
fi

if [ ! -z "$SEARCHDOMAIN" ]
then
  qm set $VMID --searchdomain "$SEARCHDOMAIN"
fi

# discs
while read SIZE; do
    NEXT_ID=0
    while qm config "$VMID" | grep -q "scsi$NEXT_ID:"; do
        ((NEXT_ID++))
    done

    qm set "$VMID" "--scsi$NEXT_ID" "${STORAGE}:${SIZE}"
done < <(echo "$DISKS_JSON" | jq -Mr ".[]")

##############################################################################
qm start $VMID
