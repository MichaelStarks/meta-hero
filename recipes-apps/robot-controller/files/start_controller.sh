#!/bin/sh
### BEGIN INIT INFO
# Provides:          start_controller
# Required-Start:    $local_fs $network $syslog
# Required-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Bring up WiFi and start robot controller
### END INIT INFO

### Configuration ###
export ROBOTID=1
export COLCON_CURRENT_PREFIX=/home/root/install
LOG_FILE="/var/log/start_controller.log"
WIFI_DONE_FLAG="/var/run/wifi_up_done"

### Functions ###
start_wifi() {
    if [ ! -f "$WIFI_DONE_FLAG" ]; then
        echo "$(date): Starting WiFi setup..." >> "$LOG_FILE"
        /usr/bin/wifi_up start >> "$LOG_FILE" 2>&1
        touch "$WIFI_DONE_FLAG"
    else
        echo "$(date): WiFi already configured, skipping" >> "$LOG_FILE"
    fi

    echo "$(date): Waiting for wlan0 IP..." >> "$LOG_FILE"
    for i in $(seq 1 20); do
        if ip addr show wlan0 | grep -q "inet "; then
            echo "$(date): wlan0 is up" >> "$LOG_FILE"
            return 0
        fi
        sleep 1
    done

    echo "$(date): ERROR: wlan0 never got an IP" >> "$LOG_FILE"
    return 1
}

start_controller() {
    echo "$(date): Sourcing ROS environment..." >> "$LOG_FILE"
    # Source only once
    . /opt/ros/jazzy/setup.sh
    . /home/root/install/setup.sh

    echo "$(date): Starting controller loop..." >> "$LOG_FILE"

    while true; do
        echo "$(date): Launching robot_controller..." >> "$LOG_FILE"
        ros2 launch /home/root/robot_controller.launch.py >> "$LOG_FILE" 2>&1
        echo "$(date): Robot controller exited — restarting in 5s..." >> "$LOG_FILE"
        sleep 5
    done &
}

stop_controller() {
    echo "$(date): Stopping controller..." >> "$LOG_FILE"

    # Stop background loop if PID file exists
    if [ -f /var/run/start_controller.pid ]; then
        LOOP_PID=$(cat /var/run/start_controller.pid)
        echo "$(date): Killing main controller loop PID $LOOP_PID" >> "$LOG_FILE"
        kill "$LOOP_PID" 2>/dev/null || true
        rm -f /var/run/start_controller.pid
    fi

    # Kill the 'ros2 launch' Python process
    ROS2_PIDS=$(ps | grep "[r]os2 launch /home/root/robot_controller.launch.py" | awk '{print $1}')
    if [ -n "$ROS2_PIDS" ]; then
        echo "$(date): Killing ros2 launch process(es): $ROS2_PIDS" >> "$LOG_FILE"
        for PID in $ROS2_PIDS; do
            kill "$PID" 2>/dev/null || true
        done
    fi

    # Kill the robot_controller binary
    CTRL_PIDS=$(ps | grep "[r]obot_controller" | grep -v "ros2 launch" | awk '{print $1}')
    if [ -n "$CTRL_PIDS" ]; then
        echo "$(date): Killing robot_controller process(es): $CTRL_PIDS" >> "$LOG_FILE"
        for PID in $CTRL_PIDS; do
            kill "$PID" 2>/dev/null || true
        done
    fi

    # Wait a bit and force kill anything left
    sleep 1
    ROS2_PIDS=$(ps | grep "[r]os2 launch /home/root/robot_controller.launch.py" | awk '{print $1}')
    CTRL_PIDS=$(ps | grep "[r]obot_controller" | grep -v "ros2 launch" | awk '{print $1}')
    if [ -n "$ROS2_PIDS$CTRL_PIDS" ]; then
        echo "$(date): Forcing remaining processes to stop" >> "$LOG_FILE"
        kill -9 $ROS2_PIDS $CTRL_PIDS 2>/dev/null || true
    fi

    echo "$(date): Controller stopped" >> "$LOG_FILE"
}

### Main control flow ###
case "$1" in
  start)
    echo "$(date): start_controller starting" >> "$LOG_FILE"
    start_wifi
    start_controller
    ;;
  stop)
    stop_controller
    ;;
  restart)
    stop_controller
    sleep 2
    start_controller
    ;;
  *)
    echo "Usage: $0 {start|stop|restart}"
    exit 1
    ;;
esac

exit 0
