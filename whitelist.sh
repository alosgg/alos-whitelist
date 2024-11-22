#!/bin/bash

# IPv4 ranges
ipv4_ranges=(
    "15.204.104.217"
)

# Clear existing rules (optional)
# iptables -F
# ip6tables -F

# Add IPv4 whitelist rules
for ip in "${ipv4_addresses[@]}"; do
    iptables -I INPUT -p tcp -m multiport --dports http,https -s "$ip" -j ACCEPT
done

# Block all other IPs for HTTP/HTTPS
iptables -A INPUT -p tcp -m multiport --dports http,https -j DROP
ip6tables -A INPUT -p tcp -m multiport --dports http,https -j DROP

echo "Firewall rules have been updated successfully!"
