#!/bin/bash

# IPv4 ranges
ipv4_ranges=(
    "15.204.104.217"
)

# Clear existing mangle rules (optional)
# iptables -t mangle -F
# ip6tables -t mangle -F

# Allow established connections first
iptables -t mangle -A PREROUTING -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
ip6tables -t mangle -A PREROUTING -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Add IPv4 whitelist rules in mangle table
for ip in "${ipv4_ranges[@]}"; do
    iptables -t mangle -A PREROUTING -p tcp -m multiport --dports http,https -s "$ip" -j ACCEPT
done

# Block all other IPs for HTTP/HTTPS at PREROUTING
iptables -t mangle -A PREROUTING -p tcp -m multiport --dports http,https -j DROP
ip6tables -t mangle -A PREROUTING -p tcp -m multiport --dports http,https -j DROP

# Add logging for dropped packets (optional)
iptables -t mangle -A PREROUTING -p tcp -m multiport --dports http,https -j LOG --log-prefix "HTTP/HTTPS DROP: " --log-level 6
ip6tables -t mangle -A PREROUTING -p tcp -m multiport --dports http,https -j LOG --log-prefix "HTTP/HTTPS DROP: " --log-level 6

echo "Mangle PREROUTING rules have been updated successfully!"