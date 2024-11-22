# ALOS IP Whitelist 🛡️

A robust IP whitelisting solution using iptables to secure your servers and prevent IP address leakage. This script ensures that only requests from authorized servers can access your HTTP/HTTPS services.

## 🔑 Key Features

- Whitelist specific IP addresses for HTTP/HTTPS access
- Support for both IPv4 and IPv6
- Blocks all other incoming HTTP/HTTPS traffic
- Prevents IP address leakage
- Simple and lightweight implementation

## 📋 Prerequisites

- Root access to your server
- `iptables` installed
- Basic understanding of firewall rules

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

The script operates in two main steps:

1. **Whitelist Rules**: Adds ACCEPT rules for specified IP addresses

2. **Default Deny Rules**: Blocks all other HTTP/HTTPS traffic

## ⚠️ Security Considerations

- Keep the IP whitelist up to date
- Regularly audit access logs
- Maintain backups of your firewall rules
- Test the rules thoroughly before implementing in production

## 🔍 Verification

To verify that the rules are properly set:

```bash
# Check IPv4 rules
sudo iptables -L -n | grep -E "http|https"
```

## ⚡ Performance Impact

The impact on server performance is minimal as the rules are processed efficiently by the kernel.

## 📄 License

This project is licensed under the MIT License and it was created with help of "pixlrs/only-cf".

## 🔐 Security

If you discover any security-related issues, please email your security team instead of using the issue tracker.

## 💬 Support

For support, please open an issue in the GitHub repository.
