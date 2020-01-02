#!/usr/bin/env bash
## note: this script runs each time awesome is called or refreshed. It provisions the desktop environment according to the user's taste
###############################################


## Conditional Runs (Different Name) 
### note: these processes spawn with different names than the command 

## Gnome Keyring
if (command -v gnome-keyring-daemon && ! pgrep gnome-keyring-d); then
    gnome-keyring-daemon --daemonize --login &
fi

## Pulse Audio for X11
if (command -v start-pulseaudio-x11 && ! pgrep pulseaudio); then
    start-pulseaudio-x11 &
fi

## Mate Polkit
if (command -v /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 && ! pgrep polkit-mate-aut) ; then
    /usr/lib/mate-polkit/polkit-mate-authentication-agent-1 &
fi

## Power Manager
if (command -v  xfce4-power-manager && ! pgrep xfce4-power-man) ; then
    xfce4-power-manager &
fi
########################################################

## Conditional Runs (Same Name)
### note: runs (only once) processes which spawn with the same name as the command 

## Template 
function run {
   if (command -v $1 && ! pgrep $1); then
     $@&
   fi
}


## XFCE Settings 
run xfsettingsd

## Network Manager Applet
run nm-applet

## Lock Screen 
run light-locker

## Hitting Left Super == L Super + L Control + Escape (for rofi)
run xcape -e 'Super_L=Super_L|Control_L|Escape'

## PulseAudio Tray Applet
run pa-applet

## Update Notifier 
run pamac-tray

## Wallpaper Setter
##run nitrogen --restore

if (command -v system-config-printer-applet && ! pgrep applet.py ); then
  system-config-printer-applet &
fi

run compton --shadow-exclude '!focused'
run blueman-applet
run msm_notifier
