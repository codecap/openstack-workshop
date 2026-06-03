#!/bin/bash
neplan apply

mkdir     /etc/squid/conf.d
chmod 755 /etc/squid/conf.d
echo "http_access allow localnet" > /etc/squid/conf.d/70-wrx-allow-localnet.conf
apt update
apt install squid -y
