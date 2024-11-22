#!/bin/bash

# IPv4 ranges
ipv4_ranges=(
    "15.204.104.217"
)

# Clear existing mangle rules (optional)
# iptables -t mangle -F PREROUTING
# ip6tables -t mangle -F PREROUTING

# Allow established connections first
iptables -t mangle -A PREROUTING -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
ip6tables -t mangle -A PREROUTING -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

# Add IPv4 whitelist rules in mangle table
for ip in "${ipv4_ranges[@]}"; do  # Fixed variable name here
    iptables -t mangle -A PREROUTING -p tcp -m multiport --dports 80,443 -s "$ip" -j ACCEPT
done

# Block all other IPs for HTTP/HTTPS at PREROUTING
iptables -t mangle -A PREROUTING -p tcp -m multiport --dports 80,443 -j DROP
ip6tables -t mangle -A PREROUTING -p tcp -m multiport --dports 80,443 -j DROP

# Add logging for dropped packets (optional)
iptables -t mangle -A PREROUTING -p tcp -m multiport --dports 80,443 -j LOG --log-prefix "HTTP/HTTPS DROP: " --log-level 6
ip6tables -t mangle -A PREROUTING -p tcp -m multiport --dports 80,443 -j LOG --log-prefix "HTTP/HTTPS DROP: " --log-level 6

echo "Mangle PREROUTING rules have been updated successfully!"

# Verify rules after adding them
echo -e "\nVerifying rules:"
iptables -t mangle -L PREROUTING -n -v