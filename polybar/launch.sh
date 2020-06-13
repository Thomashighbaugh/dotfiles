#!/usr/bin/env sh

## Add this to your wm startup file.

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar top -c ~/.config/polybar/config_desktop.ini &
        MONITOR=$m polybar bottom -c ~/.config/polybar/config_desktop.ini &


        
        
  done
else
polybar top -c ~/.config/polybar/config_desktop.ini &

polybar bottom -c ~/.config/polybar/config_desktop.ini &
fi
