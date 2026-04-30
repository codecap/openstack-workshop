#
# aliases
#
alias virsh='docker exec -ti nova_libvirt virsh'
#
# functions
#
function ovs-vsctl
{
   docker exec -ti openvswitch_vswitchd ovs-vsctl $@
}
function ovs-ofctl
{
   docker exec -ti openvswitch_vswitchd ovs-ofctl $@
}
function ovs-dpctl
{
   docker exec -ti openvswitch_vswitchd ovs-dpctl $@
}
function ovs-appctl
{
   docker exec -ti openvswitch_vswitchd ovs-appcctl $@
}
function ovn-nbctl
{
   docker exec -ti ovn_nb_db ovn-nbctl $@
}
function mysql
{
   USER=$(cat /etc/kolla/mariadb/galera.cnf | grep wsrep_sst_auth | awk '{print $NF}' | awk -F : '{print $1}')
   PSWD=$(cat /etc/kolla/mariadb/galera.cnf | grep wsrep_sst_auth | awk '{print $NF}' | awk -F : '{print $2}')
   HOST=$(cat /etc/kolla/mariadb/galera.cnf | grep bind-address | awk '{print $NF}')
   docker exec -ti mariadb mysql -h $HOST -u $USER --password=$PSWD $@
}
function get_router_state_with_id
{
  IP=$1
  HA_CONF_FILE=$(docker exec -ti neutron_l3_agent find /var/lib/neutron/ha_confs/ -name keepalived.conf -exec grep -H $IP {} \; | awk -F : '{print $1}' | head -n1)
  HA_STATE_FILE=$(dirname $HA_CONF_FILE)/state
  docker exec -ti neutron_l3_agent cat $HA_STATE_FILE
}
function netnsexec
{
  ns=$(ip netns | awk '{print $1}' | grep $1 | head -n1)
  shift
  ip netns exec $ns $@
}

function systemctlk
{
   if [ -z  "$1" ]
   then
      echo "Please pass action"
      return 1
   fi
   if [ -z  "$2" ]
   then
      echo "Please pass patter"
      return 1
   fi

  systemctl $1 kolla-$(docker ps --all | grep $2 | awk '{print $NF}' | head -n1 )-container
}

