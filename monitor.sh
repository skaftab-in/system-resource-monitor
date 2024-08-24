#!/bin/bash

# Function to display the top 10 most used applications (CPU and memory)
function top_apps {
    echo "Top 10 Most Used Applications (CPU and Memory):"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -n 11 | awk '{cmd=$3; if(length(cmd) > 20) cmd=substr(cmd, 1, 20) "..."; printf "%-8s %-8s %-25s %-8s %-8s\n", $1, $2, cmd, $4, $5}'
    echo
}

# Function to monitor network activity
function network_monitor {
    echo "Network Monitoring:"
    echo "Concurrent Connections:"
    netstat -an | grep 'ESTABLISHED' | wc -l
    echo "Packet Drops:"
    netstat -i | grep -v "Iface" | awk '{print $1 " Dropped: " $5}'
    echo "Network Traffic (MB In/Out):"
    echo "Interface | MB In | MB Out"
    awk '{if(NR>2) printf "%-10s | %-10.2f MB | %-10.2f MB\n", $1, $2/1024/1024, $10/1024/1024}' /proc/net/dev
    echo
}

# Function to display disk usage
function disk_usage {
    echo "Disk Usage:"
    df -h | grep -vE '^Filesystem|tmpfs|cdrom' | awk '{print $1 " " $5 " " $6}' | while read output;
    do
        echo $output
        usep=$(echo $output | awk '{ print $2}' | cut -d'%' -f1)
        partition=$(echo $output | awk '{print $3}')
        if [ $usep -ge 80 ]; then
            echo "Partition \"$partition\" is more than 80% full."
        fi
    done
    echo
}

# Function to display memory usage
function memory_usage {
    echo "Memory Usage:"
    free -m | awk 'NR==2{printf "Total: %s MB | Used: %s MB | Free: %s MB\n", $2, $3, $4}'
    echo "Swap Memory:"
    free -m | awk 'NR==3{printf "Total: %s MB | Used: %s MB | Free: %s MB\n", $2, $3, $4}'
    echo
}

# Function to monitor processes
function process_monitor {
    echo "Process Monitoring:"
    echo "Number of Active Processes:"
    ps aux | wc -l
    echo "Top 5 Processes (CPU and Memory):"
    ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%cpu | head -n 6 | awk '{cmd=$3; if(length(cmd) > 20) cmd=substr(cmd, 1, 20) "..."; printf "%-8s %-8s %-25s %-8s %-8s\n", $1, $2, cmd, $4, $5}'
    echo
}

# Function to monitor essential services
function service_monitor {
    echo "Service Monitoring:"
    for service in sshd nginx apache2 iptables; do
        status=$(systemctl is-active $service 2>/dev/null)
        if [ "$status" == "active" ]; then
            echo "$service is running"
        else
            echo "$service is NOT running"
        fi
    done
    echo
}

# Custom Dashboard based on command-line switches
function run_all {
    while true; do
        clear
        echo "======================"
        echo " System Resources Dashboard"
        echo "======================"
        top_apps
        network_monitor
        disk_usage
        memory_usage
        process_monitor
        service_monitor
        echo "======================"
        echo " Refreshing in 5 seconds..."
        echo " Press Ctrl+C to stop."
        sleep 5
    done
}

# Parse command-line switches
case "$1" in
    -apps) while true; do clear; top_apps; sleep 5; done ;;
    -network) while true; do clear; network_monitor; sleep 5; done ;;
    -disk) while true; do clear; disk_usage; sleep 5; done ;;
    -memory) while true; do clear; memory_usage; sleep 5; done ;;
    -process) while true; do clear; process_monitor; sleep 5; done ;;
    -services) while true; do clear; service_monitor; sleep 5; done ;;
    *) run_all ;;  # Run all functions if no switch is provided
esac

