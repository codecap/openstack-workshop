import yaml
import subprocess
import json
import ipaddress

def generate_ip(base_cidr, vm_id):
    if not base_cidr or not vm_id:
        return ""
    try:
        if "/" not in str(base_cidr):
            return str(base_cidr)
        iface = ipaddress.ip_interface(base_cidr)
        ip_parts = str(iface.ip).split('.')
        ip_parts[3] = str(vm_id)
        return f"{'.'.join(ip_parts)}/{iface.network.prefixlen}"
    except Exception:
        return str(base_cidr)

with open('conf/env.yaml', 'r') as f:
    env = yaml.safe_load(f)

server_list = env.get('server_conf', [])
network_map = env.get('network_conf', {})

for server in server_list:
    vm_id = server.get('id')
    hostname = server.get('hostname')
    netaddr_config = server.get('netaddr', "auto")
    
    netconf_obj = {}
    
    for net_key in server.get('networks', []):
        net_info = network_map.get(net_key)
        if not net_info: continue
            
        iface = net_info.get('iface')
        iface_details = {}

        # --- NEW LOGIC FOR NETADDR INTERPRETATION ---
        is_auto = False
        override = None

        if netaddr_config == "auto":
            is_auto = True
        elif isinstance(netaddr_config, dict):
            if net_key not in netaddr_config:
                # Case: Missing from dict -> Default to auto
                is_auto = True
            else:
                # Case: Key exists in dict
                override = netaddr_config.get(net_key)
                if override == "auto":
                    is_auto = True
                elif override is None:
                    # Case: external: (Null in YAML) -> empty config
                    is_auto = False 
                    override = {} 
        # --------------------------------------------

        if is_auto:
            # Standard ID-based calculation
            addr = net_info.get('addr')
            if addr:
                iface_details["ip"] = generate_ip(addr, vm_id)
            
            gw = net_info.get('gateway')
            if gw:
                iface_details["gw"] = gw.split('/')[0]
        
        elif isinstance(override, dict):
            # Static overrides (Manual IP, GW, MTU)
            if override.get('ip'):
                iface_details["ip"] = override["ip"]
            
            if override.get('gateway'):
                iface_details["gw"] = override["gateway"].split('/')[0]
            
            # Explicit MTU only if present in the override dict
            if 'mtu' in override:
                iface_details["mtu"] = str(override["mtu"])

        netconf_obj[iface] = iface_details

    # Prepare and Run
    netconf_json = json.dumps(netconf_obj)
    command = [
        "./create-vm.sh",
        "--id", str(vm_id),
        "--name", hostname,
        "--cpu", str(server.get('cpu', 1)),
        "--ram", str(server.get('ram', 2048)),
        "--disks", "'"+json.dumps(server.get('disks', []))+"'",
        "--netconf", "'"+netconf_json+"'"
    ]

    # print(f"# 🛠️  Configuring {hostname}...")
    print(" ".join(command))
    #subprocess.run(command, check=True)
