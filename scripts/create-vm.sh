


NAME=deployment
ID=16
IPBASE="10.14.0"
IP="$IPBASE.$ID"
PRXM_ID=$((300+ID))
DISKS="16,16,16"

echo qm clone 9000 $PRXM_ID --name $NAME --full
echo qm set $PRXM_ID --net0 virtio,bridge=brmgmt0
echo qm set $PRXM_ID --ipconfig0 ip=$IP/24
echo qm set $PRXM_ID --ciuser deploy


# discs
# IFS=',' read -r -a DISK_SIZES <<< "$DISKS"


echo qm start $PRXM_ID
