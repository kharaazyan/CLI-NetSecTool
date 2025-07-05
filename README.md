# Advanced CLI Network Security Tool 

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![C++20](https://img.shields.io/badge/C++-20-blue.svg)](https://isocpp.org/std/the-standard)
[![Ubuntu](https://img.shields.io/badge/Ubuntu-22.04-orange.svg)](https://ubuntu.com/)
[![Network Security](https://img.shields.io/badge/Network-Security-red.svg)](https://en.wikipedia.org/wiki/Network_security)

A powerful command-line interface (CLI) tool for network security analysis, vulnerability scanning, and penetration testing. Built with modern C++20 and designed for security professionals and ethical hackers.

## 🚀 Features

### **Network Security Analysis**
- **Port Scanning**: Fast TCP/UDP port discovery with customizable timing
- **Service Detection**: Identify running services and their versions
- **Vulnerability Assessment**: Automated security testing and reporting
- **Network Mapping**: Visualize network topology and device relationships

### **Advanced CLI Interface**
- **Interactive Mode**: Real-time command execution with history
- **Batch Processing**: Execute multiple commands from scripts
- **Color-coded Output**: Enhanced readability with termcolor library
- **Progress Indicators**: Real-time feedback for long-running operations

### **Security Tools**
- **SSL/TLS Analysis**: Certificate validation and cipher suite testing
- **HTTP Security Headers**: Check for common security misconfigurations
- **DNS Enumeration**: Subdomain discovery and DNS security testing
- **Network Traffic Analysis**: Packet capture and protocol analysis

### **Reporting & Documentation**
- **JSON Output**: Structured data for automated processing
- **HTML Reports**: Professional security assessment reports
- **CSV Export**: Data export for spreadsheet analysis
- **Logging**: Comprehensive audit trail with multiple log levels

## 📊 Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   CLI Interface │    │  Core Engine    │    │  Network Layer  │
│                 │    │                 │    │                 │
│ ┌─────────────┐ │    │ ┌─────────────┐ │    │ ┌─────────────┐ │
│ │ Command     │ │    │ │ Scanner     │ │    │ │ TCP/UDP     │ │
│ │ Parser      │ │    │ │ Engine      │ │    │ │ Sockets     │ │
│ └─────────────┘ │    │ └─────────────┘ │    │ └─────────────┘ │
│ ┌─────────────┐ │    │ ┌─────────────┐ │    │ ┌─────────────┐ │
│ │ Interactive │ │───▶│ │ Security    │ │───▶│ │ SSL/TLS     │ │
│ │ Shell       │ │    │ │ Analyzer    │ │    │ │ Handshake   │ │
│ └─────────────┘ │    │ └─────────────┘ │    │ └─────────────┘ │
│ ┌─────────────┐ │    │ ┌─────────────┐ │    │ ┌─────────────┐ │
│ │ Report      │ │    │ │ Vulnerability│ │    │ │ HTTP/HTTPS  │ │
│ │ Generator   │ │    │ │ Database    │ │    │ │ Client      │ │
│ └─────────────┘ │    │ └─────────────┘ │    │ └─────────────┘ │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 🛠️ Technology Stack

- **Language**: C++20 with modern features
- **Networking**: libcurl for HTTP/HTTPS operations
- **Cryptography**: OpenSSL for SSL/TLS analysis
- **JSON Processing**: nlohmann/json for data serialization
- **Terminal UI**: termcolor for colored output
- **System APIs**: POSIX sockets, threading

## 📁 Project Structure

```
sergo/
├── src/                     # Source files
│   ├── cli.cpp             # Main CLI interface
│   ├── scanner.cpp         # Network scanning engine
│   ├── security.cpp        # Security analysis tools
│   └── utils.cpp           # Utility functions
├── include/                 # Header files
│   ├── cli.hpp             # CLI interface definitions
│   ├── scanner.hpp         # Scanner engine headers
│   ├── security.hpp        # Security analysis headers
│   └── utils.hpp           # Utility function headers
├── keys/                    # SSL certificates & keys
├── external/                # External dependencies
│   ├── json.hpp            # nlohmann/json library
│   └── termcolor.hpp       # Terminal color library
├── makefile                 # Build system
├── .gitignore              # Git ignore rules
└── README.md               # This file
```

## 🔧 Installation

### Prerequisites

- Ubuntu 22.04 LTS
- C++20 compatible compiler (GCC 10+ or Clang 12+)
- Network access for security testing

### Quick Start

```bash
# Clone repository
git clone https://github.com/your-org/sergo.git
cd sergo

# Install dependencies and build
make deps
make all

# Install to system
make install
```

### Manual Installation

```bash
# Install system dependencies
sudo apt-get update
sudo apt-get install -y build-essential libcurl4-openssl-dev libssl-dev

# Build project
make
```

## 🚀 Usage

### Basic Commands

```bash
# Start interactive shell
./bin/sergo

# Scan a single host
./bin/sergo scan 192.168.1.1

# Scan a network range
./bin/sergo scan 192.168.1.0/24

# Check SSL certificate
./bin/sergo ssl https://example.com

# HTTP security headers
./bin/sergo headers https://example.com
```

### Interactive Mode

```bash
$ ./bin/sergo
Sergo Security Scanner v1.0.0
Type 'help' for available commands

sergo> scan 192.168.1.1
[+] Starting scan of 192.168.1.1
[+] Found open ports: 22, 80, 443
[+] Service detection completed

sergo> ssl 192.168.1.1:443
[+] SSL Certificate Analysis
[+] Valid until: 2024-12-31
[+] Cipher: TLS_AES_256_GCM_SHA384

sergo> exit
```

### Batch Mode

```bash
# Execute commands from file
./bin/sergo -f commands.txt

# Example commands.txt:
# scan 192.168.1.1
# ssl 192.168.1.1:443
# headers https://192.168.1.1
```

## 🔒 Security Features

### **Port Scanning**
- **TCP Connect**: Standard connection-based scanning
- **TCP SYN**: Stealth SYN scanning (requires root)
- **UDP Scanning**: UDP port discovery
- **Service Detection**: Banner grabbing and version detection

### **SSL/TLS Analysis**
- **Certificate Validation**: Expiry, issuer, subject verification
- **Cipher Suite Testing**: Supported encryption algorithms
- **Protocol Support**: TLS version compatibility
- **Security Headers**: HSTS, CSP, X-Frame-Options analysis

### **Vulnerability Assessment**
- **Common Vulnerabilities**: CVE database integration
- **Misconfiguration Detection**: Security header analysis
- **Weak Cipher Detection**: Insecure encryption identification
- **Certificate Issues**: Self-signed, expired, or invalid certificates

## 📈 Performance

- **Scan Speed**: 1000+ ports/second
- **Memory Usage**: <100MB for large scans
- **Concurrent Connections**: 100+ simultaneous connections
- **Report Generation**: <5 seconds for standard reports

## 🧪 Development

### Building

```bash
# Debug build
make BUILD=debug

# Release build
make BUILD=release

# Verbose build
make V=1
```

### Testing

```bash
# Run unit tests
make test

# Run integration tests
make test-integration

# Code coverage
make coverage
```

### Development Tools

```bash
# Clean build artifacts
make clean

# Clean all (including dependencies)
make clean-all

# Rebuild everything
make rebuild

# Format code
make format

# Lint code
make lint
```

## 🔧 Configuration

### Environment Variables

```bash
export SERGO_LOG_LEVEL=INFO
export SERGO_TIMEOUT=30
export SERGO_THREADS=10
export SERGO_OUTPUT_FORMAT=json
```

### Configuration File

Create `sergo.conf` in the project root:

```ini
[scanning]
timeout = 30
threads = 10
retries = 3

[output]
format = json
log_level = info
color_output = true

[security]
verify_ssl = true
follow_redirects = true
user_agent = Sergo/1.0
```

## 📊 Output Formats

### JSON Output

```json
{
  "scan": {
    "target": "192.168.1.1",
    "timestamp": "2024-01-15T10:30:00Z",
    "ports": [
      {
        "port": 80,
        "state": "open",
        "service": "http",
        "version": "Apache/2.4.41"
      }
    ]
  }
}
```

### HTML Report

```html
<!DOCTYPE html>
<html>
<head>
    <title>Sergo Security Scan Report</title>
    <style>
        .vulnerability { color: red; }
        .warning { color: orange; }
        .info { color: blue; }
    </style>
</head>
<body>
    <h1>Security Scan Report</h1>
    <!-- Detailed report content -->
</body>
</html>
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

### Development Guidelines

- Follow C++20 best practices
- Implement comprehensive error handling
- Add unit tests for new features
- Use RAII for resource management
- Document all public APIs

### Code Style

```cpp
// Use modern C++ features
auto result = std::make_unique<ScanResult>();

// RAII for resource management
class SocketGuard {
    int sock_fd;
public:
    SocketGuard(int fd) : sock_fd(fd) {}
    ~SocketGuard() { close(sock_fd); }
};

// Exception safety
try {
    perform_scan(target);
} catch (const std::exception& e) {
    logger.error("Scan failed: {}", e.what());
}
```

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚠️ Legal Notice

**Important**: This tool is designed for authorized security testing only. Users are responsible for ensuring they have proper authorization before scanning any network or system. The authors are not responsible for any misuse of this software.

### Ethical Usage Guidelines

- Only scan systems you own or have explicit permission to test
- Respect rate limits and network policies
- Report vulnerabilities responsibly
- Follow responsible disclosure practices
- Comply with local and international laws

## 🙏 Acknowledgments

- **libcurl**: Daniel Stenberg for HTTP client library
- **OpenSSL**: OpenSSL Project for cryptographic functions
- **nlohmann/json**: Niels Lohmann for JSON library
- **termcolor**: Ihor Kalnytskyi for terminal colors

## 📞 Support

- **Issues**: [GitHub Issues](https://github.com/your-org/sergo/issues)
- **Discussions**: [GitHub Discussions](https://github.com/your-org/sergo/discussions)
- **Documentation**: [Wiki](https://github.com/your-org/sergo/wiki)
- **Security**: security@your-org.com

## 🔗 Related Projects

- **[Nexus](https://github.com/your-org/nexus)**: Real-time system monitoring agent
- **[Atlas](https://github.com/your-org/atlas)**: Network infrastructure management
- **[PicsArt Academy](https://github.com/your-org/picsart-academy)**: Educational platform

---

**Sergo** - Advanced network security analysis at your fingertips. 🔍🛡️ 