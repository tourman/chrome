#!/bin/bash
set -e

# When docker restarts, this file is still there,
# so we need to kill it just in case
[ -f /tmp/.X99-lock ] && rm -f /tmp/.X99-lock

_kill_procs() {
  kill -TERM $xvfb
}

# Relay quit commands to processes
trap _kill_procs SIGTERM SIGINT

if [ -z "$DISPLAY" ]
then
  Xvfb :99 -screen 0 1024x768x16 -nolisten tcp -nolisten unix &
  xvfb=$!
  export DISPLAY=:99
fi

service dbus start
export XDG_RUNTIME_DIR=/run/user/$(id -u)
mkdir $XDG_RUNTIME_DIR
chmod 700 $XDG_RUNTIME_DIR
chown $(id -un):$(id -gn) $XDG_RUNTIME_DIR
export DBUS_SESSION_BUS_ADDRESS=unix:path=$XDG_RUNTIME_DIR/bus
dbus-daemon --session --address=$DBUS_SESSION_BUS_ADDRESS --nofork --nopidfile --syslog-only &

google-chrome-stable --disable-gpu --no-sandbox --disable-software-rasterizer --disable-dev-shm-usage --remote-debugging-port=9222