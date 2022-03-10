#!/bin/sh
# Default acpi script that takes an entry for all actions

# NOTE: This is a 2.6-centric script.  If you use 2.4.x, you'll have to
#       modify it to not use /sys

set $*

XDG_RUNTIME_DIR="/tmp/omar-runtime/"
if [ -d "$XDG_RUNTIME_DIR" ]; then
  WAYLAND_DISPLAY=$(find $XDG_RUNTIME_DIR -name "wayland-*" -type s -printf "%f" -quit)
  # SWAYSOCK=$(find $XDG_RUNTIME_DIR -name "sway-ipc.*" -type s -printf "%f" -quit)
fi

# minspeed=$(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_min_freq)
# maxspeed=$(cat /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq)
# setspeed="/sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed"

case "$1" in
  button/power)
    #echo "PowerButton pressed!">/dev/tty5
    case "$2" in
      PBTN|PWRF)
        logger "PowerButton pressed: $2, shutting down..."
        shutdown -P now
        ;;
      *)      logger "ACPI action undefined: $2" ;;
    esac
    ;;
  button/sleep)
    case "$2" in
      SBTN|SLPB)
        # don't suspend-to-ram
        logger "Sleep Button pressed: $2"
        ;;
      *)      logger "ACPI action undefined: $2" ;;
    esac
    ;;
  button/f20)
    case "$2" in
      *)
        MIC_BTN=/sys/devices/platform/thinkpad_acpi/leds/platform::micmute/brightness
        [ -f $MIC_BTN ] || return
        if [ $(cat $MIC_BTN) -eq 0 ]; then
          echo 1 > $MIC_BTN
          logger "Mic mute led on"
        else
          echo 0 > $MIC_BTN
          logger "Mic mute led off"
        fi
        ;;
    esac
    ;;
  ac_adapter)
    case "$2" in
      ACPI0003:00)
        case "$4" in
          00000000)
            logger "Plugged out"
            for i in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
              echo "schedutil" > $i;
            done
            # echo -n $minspeed >$setspeed
            #/etc/laptop-mode/laptop-mode start
            ;;
          00000001)
            logger "Plugged in"
            for i in /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor; do
              echo "performance" > $i;
            done
            # echo -n $maxspeed >$setspeed
            #/etc/laptop-mode/laptop-mode stop
            ;;
        esac
        ;;
      *)  logger "ACPI action undefined: $2" ;;
    esac
    ;;
  battery)
    case "$2" in
      BAT0)
        case "$4" in
          00000000)   #echo "offline" >/dev/tty5
            ;;
          00000001)   #echo "online"  >/dev/tty5
            ;;
        esac
        ;;
      CPU0)
        ;;
      *)  logger "ACPI action undefined: $2" ;;
    esac
    ;;
  button/lid)
    case "$3" in
      close)
        # NOTE: would be nice if zzz worked on my thinkpad :(
        logger "LID closed"
        # lock screen
        # FIXME: not sure why WAYLAND_DISPLAY is not exported
        # Though I understand why XDG_RUNTIME_DIR is not
        # Also, there is a delay where lockscreen is not shown
        [ -z "$WAYLAND_DISPLAY" ] || runuser -l omar -c "XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR WAYLAND_DISPLAY=$WAYLAND_DISPLAY setsid -f waylock"
        # disable services
        sv down iwd
        sv down bluetoothd
        zzz
        ;;
      open)
        # enable laptop screen
        logger "LID opened"
        # enable services again
        sv up iwd
        sv up bluetoothd
        ;;
      *) logger "ACPI action undefined (LID): $2";;
    esac
    ;;
  *)
    logger "ACPI group/action undefined: $1 / $2"
    ;;
esac
