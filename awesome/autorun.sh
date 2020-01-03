#!/usr/bin/env bash
#####################################################################
#####################################################################
########### Awesome Window Manager AutoStart Script #################
#####################################################################
#####################################################################
## note: this script runs each time awesome is called or refreshed. It provisions the desktop environment according to the user's taste
### note: an xprofile file can also be used to accomplish these tasks and do so only once but I prefer this method for debugging purposes (in case these programs' settings change)

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

if (command -v system-config-printer-applet && ! pgrep applet.py ); then
  system-config-printer-applet &
fi

#####################################################################
######################### Function 'run' ############################
#####################################################################
### note: function 'run' is for programs which spawn processes with the same name as the command

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


## Compositor
run compton

## Bluetooth Manager
run blueman-applet

## Notifications
run msm_notifier
