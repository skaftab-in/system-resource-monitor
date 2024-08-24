# System Resource Monitor Script

This script provides a comprehensive overview of system resources, including CPU and memory usage, disk usage, network activity, and essential services monitoring. It is designed to run continuously, refreshing the data every 5 seconds.

## Features

- **Top 10 Applications**: Display the most resource-intensive applications by CPU and memory usage.
- **Network Monitoring**: Show concurrent network connections, packet drops, and network traffic (in/out).
- **Disk Usage**: Display disk usage with a warning for partitions exceeding 80% usage.
- **Memory Usage**: Show detailed memory usage, including swap memory.
- **Process Monitoring**: Display the number of active processes and the top 5 processes by CPU and memory usage.
- **Service Monitoring**: Check the status of essential services such as SSH, NGINX, Apache, and Iptables.

## Prerequisites

Ensure that the following commands are available on your system:

- `ps` - Process status tool
- `awk` - Text processing tool
- `netstat` - Network statistics (install `net-tools` package if not available)
- `df` - Disk space usage
- `free` - Memory usage information
- `systemctl` - Service management

You can install the necessary tools on a Debian-based system (like Ubuntu) using:

```bash
sudo apt-get install procps net-tools coreutils util-linux



Usage
You can run the script with the following options:

-apps - Continuously display the top 10 resource-intensive applications by CPU and memory usage.
-network - Continuously display network activity, including concurrent connections and packet drops.
-disk - Continuously display disk usage and highlight partitions with over 80% usage.
-memory - Continuously display detailed memory usage, including swap.
-process - Continuously display the number of active processes and the top 5 processes by resource usage.
-services - Continuously display the status of essential services like SSH, NGINX, Apache, and Iptables.
* (default) - Run all monitoring functions if no switch is provided.
