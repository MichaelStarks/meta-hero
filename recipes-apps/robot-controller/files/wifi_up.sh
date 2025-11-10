#!/bin/sh
### BEGIN INIT INFO
# Provides:          wifi_up
# Required-Start:    $local_fs $network $syslog
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Bring up WiFi with static IP
### END INIT INFO

CONFIG_FILE="/etc/wifi_up.conf"
LOG_FILE="/var/log/wifi_up.log"

# Load config if present
if [ -f "$CONFIG_FILE" ]; then
    . "$CONFIG_FILE"
else
    IP_ADDR="192.168.1.132"
    NETMASK="24"
    GATEWAY="192.168.1.1"
fi

case "$1" in
  start)
    echo "$(date): wifi_up starting" >> "$LOG_FILE"

    # Wait until wlan0 exists
    i=0
    while ! ip link show wlan0 >/dev/null 2>&1; do
        if [ $i -ge 10 ]; then
            echo "$(date): wlan0 not found, giving up" >> "$LOG_FILE"
            exit 1
        fi
        sleep 1
        i=$((i+1))
    done

    # Bring up WiFi
    wpa_supplicant -B -i wlan0 -c /etc/wpa_supplicant.conf
    sleep 2

    ip addr flush dev wlan0
    ip addr add ${IP_ADDR}/${NETMASK} dev wlan0
    ip route add default via ${GATEWAY}

    echo "$(date): wifi_up done" >> "$LOG_FILE"
    ;;
  stop)
    killall wpa_supplicant 2>/dev/null || true
    ;;
  restart)
    $0 stop
    $0 start
    ;;
  status)
    ip addr show wlan0
    ;;
  *)
    echo "Usage: $0 {start|stop|status|restart}"
    exit 1
    ;;
esac

exit 0
