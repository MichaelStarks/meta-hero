#!/bin/sh

WIFI_CONF="/etc/wifi_up.conf"

usage() {
    echo "Usage: $0 [--hostname NAME] [--ip IP] [--mask MASK] [--gw GATEWAY]"
    echo "Example: $0 --hostname pi-zero --ip 10.0.0.50 --mask 24 --gw 10.0.0.1"
}

# Show help if no arguments
[ $# -eq 0 ] && usage && exit 0

# Parse arguments
while [ $# -gt 0 ]; do
    case "$1" in
        --hostname)
            shift
            HOSTNAME="$1"
            ;;
        --ip)
            shift
            NEW_IP="$1"
            ;;
        --mask)
            shift
            NEW_MASK="$1"
            ;;
        --gw)
            shift
            NEW_GW="$1"
            ;;
        *)
            usage
            exit 1
            ;;
    esac
    shift
done

# Change hostname if requested
if [ -n "$HOSTNAME" ]; then
    echo "$HOSTNAME" > /etc/hostname
    hostname "$HOSTNAME"
    echo "Hostname set to $HOSTNAME"
fi

# Update WiFi IP config persistently
cat <<EOF > "$WIFI_CONF"
IP_ADDR="${NEW_IP:-10.0.0.132}"
NETMASK="${NEW_MASK:-24}"
GATEWAY="${NEW_GW:-10.0.0.1}"
EOF

echo "WiFi configuration updated in $WIFI_CONF"
echo "Use '/etc/init.d/wifi_up.sh restart' to apply changes immediately"
