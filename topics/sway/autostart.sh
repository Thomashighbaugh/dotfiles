#!/usr/bin/env bash

## Function Definition
function run {
    if (command -v $1 && ! pgrep $1); then
        
        $@ &
    fi
}

## Functions
# Note: Most of these are now commented out, as I have an autostart script for awesome (and other window managers) which includes these but allow for a per-situation customization level not present in this generalized file. I have left them present for purposes of reference for the others.


### Hitting Left Super == L Super + L Control + Escape (for rofi)
run xcape -e 'Super_L=Super_L|Control_L|Escape'

### Compositor
run picom -b --experimental-backends --dbus --config $HOME/.config/picom.conf

### Bluetooth Manager
run blueman-applet

### Notifications
run dunst

### PulseAudio Tray Applet
run pa-applet

### XFCE Settings
run xfsettingsd

### XFCE Settings for GTK theme consistency
run xfce4-settings-daemon

### Network Manager Applet
run nm-applet

### Screen Saver
run xscreensaver
## Allows automounting drives (useful sometimes, often a pain)
run udiskie
# mouse disappears
run unclutter

## Turn on settings manager (allows gtk styling to work consistently, power manager for my laptop, etc)
run xfce4-settings-daemon

### Dropbox
run ~/.dropbox-dist/dropboxd &

## Merging Xresources
xrdb -merge $HOME/.Xresources
