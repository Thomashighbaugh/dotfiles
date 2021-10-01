#!/bin/ash

echo "Alpine Linux Setup - Post Installation"
echo
echo "System Core Packages"
echo
echo
echo
echo "Please Remember to add kms to your mkinitfs file"

--yesno "Are You Ready to Begin?" 7 60


APKADD(){
    while(($# > 0)); do
        sudo apk add "$!"
        shift
    done
    return
}

RCSTART(){
    rc-service "$!" start
}

RCADD(){
    rc-update add "$!"
}



setup-xorg-base openbox terminator slim dbus-x11 xf86-video-intel
xf86-video-ati xf86-video-amdgpu xf86-input-mouse xf86-input-keyboard setxkbmap

APKADD acct acf-apk-tools adwaita-icon-theme adwaita-qt albatross-themes-xfwm4 alpine-base alpine-conf alpine-sdk alsa-lib-dev alsa-plugins alsa-plugins-lavrate alsa-plugins-pulse alsa-tools alsa-tools-dev alsa-tools-gui alsa-topology-conf alsa-ucm-conf alsa-utils alsa-utils-dbg alsaconf apk-cron apk-file apk-gtk3 apk-gtk3-policy apk-polkit-rs apk-polkit-rs-dbg apk-polkit-rs-dev apk-post-messages apk-tools apk-tools-dev apk-tools-doc apk-tools-static apk-tools-zsh-completion apkbuild-cpan apkbuild-gem-resolver apkbuild-pypi apparmor-utils aspell-utils asterisk-alsa atools audiofile autoconf autoconf-archive automake automake-doc avahi-ui-dev boost boost-dev boost-filesystem boost-regex boost-system build-base busybox bzip2 cairo cairo-dev cairomm-dev chrony ciwiki clutter-gtk cmake cmake-bash-completion cmake-extras coreutils cpio curl-dev dateutils db-utils dbus-cpp dbus-glib dbus-libs dbus-x11 dia docker docker-cli-buildx docker-cli-compose docker-compose docker-engine docker-openrc docker-registry docker-registry-openrc docker-zsh-completion dosfstools doxygen dunst e2fsprogs elfutils elogind eudev eudev-doc eudev-libs eudev-openrc eudev-rule-generator extra-cmake-modules faenza-icon-theme faenza-icon-theme-thunar fakeroot feh ffmpeg ffmpeg-dev ffmpeg-libs ffmpegthumbs findutils firefox flatpak flatpak-builder flatpak-dbg flatpak-dev flatpak-libs flatpak-zsh-completion freeglut freeglut-dev fsarchiver fuse-overlayfs gccmakedep gcompat gd gdk-pixbuf-dbg gdk-pixbuf-dev gdk-pixbuf-xlib giflib gifsicle git glew glew-dev glfw glib glibd glibmm glm-dev glog glog-dev glslang gnome-disk-utility gnome-icon-theme gnome-software gnome-software-dev gnome-software-plugin-apk gnome-software-plugin-flatpak gparted grep greybird-themes-xfwm4 grub-efi gst-plugins-bad gst-plugins-base gst-plugins-base-dev gst-plugins-good gtk+2.0 gtk+3.0 gtk-engines gtk-layer-shell-dev gtk4.0 gtkmm4 gtksourceview4-lang gtkspell-dev gtkspell3 gvfs gvfs-archive gzip hicolor-icon-theme htop imagemagick imagemagick-zsh-completion imake inkscape installkernel kitty kitty-wayland kitty-x11 kvantum libapk-qt-dbg libapk-qt-dev libarchive libarchive-tools libcanberra-alsa libcanberra-gtk3 libchamplain-dev libconfig libconfig-dev libcurl libdbusmenu-glib libdbusmenu-gtk3 libev libev-dev libfm libfm-dev libgudev libinput-debug-gui libinput-tools libmpack-dev libpcre32 libpeas libpulse libraw-tools librsvg libtool libuv libuv-dbg libuv-dev libuv-static libwebp-tools libwnck3 libwnck3-dev libwpg-tools libx11 libx11-dev libxcb libxcb-dev libxcb-doc libxdg-basedir-dev libxinerama libxinerama-dev libxinerama-doc lightdm-gtk-greeter linux-lts lrzip lua lua-json4 lua5.3-apk lua5.3-cjson lua5.3-coxpcall lua5.3-cqueues-pushy lua5.3-dev lua5.3-evdev lua5.3-fifo lua5.3-filesystem lua5.3-glob-pattern lua5.3-hiredis lua5.3-lgi lua5.3-lpeg lua5.3-luasrcdiet lua5.3-lxc lua5.3-lzlib lua5.3-md5 lua5.3-microlight lua5.3-moonscript lua5.3-mpack lua5.3-openrc lua5.3-penlight lua5.3-posix lua5.3-posixtz lua5.3-sec lua5.3-socket lua5.3-struct lua5.3-system lua5.3-term lua5.3-yaml luajit-dev luajit-doc luarocks luarocks5.3 m4 mdadm-udev mesa meson meson-bash-completion meson-vim meson-zsh-completion mtools network-manager-applet numix-icon-theme-circle-light numix-themes-gtk3 numix-themes-xfwm4 openbox openjdk8 openssh openssh-server openssl openvswitch optipng os-prober pcre pcre-tools pcre2 pcre2-dev peek peek-lang perl-config-autoconf perl-data-peek picom polkit-elogind pulseaudio-alsa pulseaudio-bash-completion pulseaudio-ctl pulseaudio-ctl-zsh-completion pulseaudio-equalizer pulseaudio-openrc pulseaudio-utils pulseaudio-zeroconf pulseaudio-zsh-completion py3-cairosvg py3-dbus py3-dockerpty py3-gobject3 py3-pip py3-pip-bash-completion py3-pip-zsh-completion py3-pyalsaaudio py3-setuptools py3-udev py3-xlib python2 python2-dev python3 qrupdate-dev qt5-qtsvg-dev qt6-qtsvg sassc sed slim squashfs-tools strongswan subunit sudo swig syslinux terminator thunar thunar-archive-plugin thunar-archive-plugin-lang thunar-dev thunar-doc thunar-lang thunar-vcs-plugin thunar-vcs-plugin-git thunar-vcs-plugin-lang thunar-vcs-plugin-svn thunar-volman thunar-volman-lang udev-init-scripts udisks2 unzip uthash uthash-dev vim vlc wireless-tools wpa_supplicant wxgtk wxgtk-base wxgtk-base-dev wxgtk-dev xarchiver xcb-proto xcb-util xcb-util-cursor xcb-util-cursor-dev xcb-util-dev xcb-util-image xcb-util-image-dev xcb-util-keysyms xcb-util-keysyms-dev xcb-util-renderutil xcb-util-renderutil-dev xcb-util-wm xcb-util-wm-dev xcb-util-xrm xcb-util-xrm-dev xdg-dbus-proxy xdg-desktop-portal xdg-desktop-portal-gtk xdg-desktop-portal-gtk-lang xdg-desktop-portal-lang xdg-user-dirs xdg-utils-doc xf86-input-evdev xf86-input-evdev-dev xf86-input-libinput xf86-input-libinput-dev xf86-input-synaptics xf86-input-synaptics-dev xf86-input-wacom xf86-video-intel xfce4 xfce4-pulseaudio-plugin xfce4-pulseaudio-plugin-lang xfwm4-lang xfwm4-themes xorg-server xorgproto xorriso xproto xscreensaver xset xset-doc xsetmode xsetroot xsetroot-doc xz youtube-dl zsh zziplib-utils


flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo

export PAGER=less



echo fbcon >> /etc/modules



RCADD dbus
RCSTART dbus

RCSTART fuse
RCADD fuse

# Fonts

APKADD terminus-font ttf-inconsolata ttf-dejavu font-bitstream-* ttf-font-awesome





