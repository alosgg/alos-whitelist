# ALOS IP Whitelist 🛡️

A robust IP whitelisting solution using iptables mangle table to secure your servers and prevent IP address leakage. This script implements early packet filtering at the PREROUTING chain level for enhanced security and performance.

## 🔑 Key Features

- Early packet filtering using mangle table and PREROUTING chain
- Efficient handling of established connections
- Whitelist specific IP addresses for HTTP/HTTPS access
- Support for both IPv4 and IPv6
- Blocks all other incoming HTTP/HTTPS traffic
- Prevents IP address leakage
- Optional packet logging for security monitoring
- Simple and lightweight implementation

## 📋 Prerequisites

- Root access to your server
- `iptables` installed
- `conntrack` module enabled
- Understanding of firewall rules and netfilter

## 🚀 Installation

1. Clone the repository:
```bash
git clone https://github.com/alosgg/alos-whitelist.git
cd alos-whitelist
```

2. Make the script executable:
```bash
chmod +x whitelist.sh
```

## 🔧 Usage

Run the script with root privileges:
```bash
sudo ./whitelist.sh
```

## 📝 How It Works

The script operates in three main steps:

1. **Connection Tracking**: Allows established connections to maintain functionality

2. **Whitelist Rules**: Adds ACCEPT rules for specified IP addresses at the PREROUTING chain

3. **Default Deny Rules**: Blocks all other HTTP/HTTPS traffic early in the packet processing pipeline

## ⚠️ Security Considerations

- Keep the IP whitelist up to date
- Regularly audit access logs
- Maintain backups of your firewall rules
- Test the rules thoroughly before implementing in production
- Monitor the logs for dropped packets if logging is enabled

## 🔍 Verification

To verify that the rules are properly set:

```bash
# Check IPv4 mangle rules
sudo iptables -t mangle -L PREROUTING -n | grep -E "http|https"

# Check connection tracking rules
sudo iptables -t mangle -L PREROUTING -n | grep "RELATED,ESTABLISHED"
```

## ⚡ Performance Impact

The impact on server performance is minimized as:
- Packets are filtered early in the netfilter chain
- Established connections are handled efficiently
- Unwanted traffic is dropped before reaching higher levels of processing

## 📄 License

This project is licensed under the MIT License and it was inspired by "pixlrs/only-cf".

## 🔐 Security

If you discover any security-related issues, please email your security team instead of using the issue tracker.

## 💬 Support

For support, please open an issue in the GitHub repository.
