#!/bin/bash
#
#
# This is for installing the packages I use on my system, taken from what was installed, hence the huge list.
#######################################################################################################################################
cr="$(tput setaf 1)"
cg="$(tput setaf 2)"
cy="$(tput setaf 3)"
cm="$(tput setaf 5)"
sb="$(tput bold)"
sn="$(tput sgr0)"

print() {
    case "$1" in
    t | title)
        shift
        printf "%s\n" "${sb}${cg}[###]$*${sn}"
        ;;
    s | step)
        shift
        printf "%s\n" "${sb}${cm}[===]$*${sn}"
        ;;
    e | error)
        shift
        printf "%s\n" "${sb}${cr}[!!!]$*${sn}"
        exit 1
        ;;
    w | warning)
        shift
        printf "%s\n" "${sb}${cy}[:::]$*${sn}"
        ;;
    *)
        printf '%s\n' "$*"
        ;;
    esac
}

# void installer
installPackages() {
    print s "###############################################################################"
    print s "Begin Package Installation"
    print s "###############################################################################"
    sudo xbps-install -Su -y xbps
    sudo xbps-install -Su
    sudo xbps-install -S -y void-repo-nonfree void-release-keys signify dialog
    sudo xbps-install -S -y void-repo-debug atool bash bwm-ng chrony dosfstools dracut exfat-utils ntfs-3g fcron fd ffmpeg glances hddtemp
    sudo xbps-install -S -y zsh git inetutils inxi iproute2 kbd linux-firmware linux-firmware-intel lm_sensors
    sudo xbps-install -S -y lnav lr mle nano ncurses ncurses-devel nfs-utils opendoas openssh p7zip pciutils
    sudo xbps-install -S -y rsnapshot smartmontools socklog-void tree vsv wget xterm gcc dtach make git pkg-config man-pages
    sudo xbps-install -S -y mdocml curl gptfdisk unzip unrar zstd ranger font-tamsyn starship xz lshw fuse-sshfs
    sudo xbps-install -S -y borg ncdu lsscsi lsof pam detox vscode
    sudo xbps-install -S -y chromium filezilla firefox herbstluftwm iwd kid3 libinput-gestures linux-firmware-nvidia
    sudo xbps-install -S -y micro smplayer sndio tlp xf86-input-wacom xorg-minimal sakura mesa mesa-demos mesa-vulkan-intel
    sudo xbps-install -S -y mesa-nouveau-dri mesa-intel-dri mesa-dri mesa-vaapi mesa-vdpau autorandr w3m-img sxiv xwallpaper mupdf aerc bind-utils unbound dnscrypt-proxy wavpack-devel libmp4v2-devel libflac-devel libsndfile-devel libvorbis-devel mpg123-devel faad2-devel sndio-devel opusfile-devel papirus-icon-theme aucatctl
    sudo xbps-install -S -y sox polybar vlc w_scan xset fontmanager libmnl-devel dialog ghostwriter dunst udiskie keychain nemo nemo-fileroller ffmpegthumbnailer gvfs gvfs-afp gvfs-cdda gvfs-smb gvfs-afc gvfs-mtp gvfs-gphoto2
    sudo xbps-install -S -y gconf-editor mpv alsa-utils libopenal upower gtk+3 qalculate xclip rofi rofi-calc fzy fzf xwininfo redshift-gtk xbanish arc-theme arc-icon-theme faience-icon-theme faenza-icon-theme xsetroot recoll
    sudo xbps-install -S -y i3lock-color dbus-elogind-x11 asciiquarium astroid nerd-fonts noto-fonts-cjk overpass-otf google-fonts-ttf font-iosevka emacs-x11 autocutsel shellcheck caddy binutils tar curl xbps xz
    sudo xbps-install -S -y GConf ImageMagick LuaJIT LuaJIT-devel MesaLib-devel NetworkManager SDL2
    sudo xbps-install -S -y Thunar VirtualGL Vulkan-Headers Vulkan-Tools aalib accountsservice
    sudo xbps-install -S -y acl acpid adwaita-icon-theme aerc alacritty alacritty-terminfo
    sudo xbps-install -S -y alsa-lib alsa-lib-devel alsa-plugins-pulseaudio alsa-utils amiri-font
    sudo xbps-install -S -y appstream-glib arandr arc-icon-theme arc-theme asciiquarium astroid
    sudo xbps-install -S -y at-spi2-atk at-spi2-atk-devel at-spi2-core at-spi2-core-devel atk
    sudo xbps-install -S -y atk-devel atkmm atool attr aucatctl autoconf autocutsel autogen automake
    sudo xbps-install -S -y autorandr avahi-glib-libs avahi-libs awesome base-files base-system bash
    sudo xbps-install -S -y bind-libs bind-utils binutils binutils-doc boost borg brotli btrfs-progs
    sudo xbps-install -S -y bubblewrap bwm-ng bzip2 bzip2-devel c-ares cJSON ca-certificates
    sudo xbps-install -S -y caddy cairo cairo-devel cairomm caja caja-dropbox caja-extensions
    sudo xbps-install -S -y caja-image-converter caja-open-terminal caja-sendto caja-share
    sudo xbps-install -S -y caja-wallpaper caja-xattr-tags cantarell-fonts celt chromaprint chrony
    sudo xbps-install -S -y cinnamon-desktop cinnamon-translations cmake colord-devel coreutils
    sudo xbps-install -S -y cpio cryptsetup cups-devel curl dash dbus dbus-devel dbus-elogind-x11
    sudo xbps-install -S -y dbus-glib dbus-libs dconf dejavu-fonts-ttf desktop-file-utils detox
    sudo xbps-install -S -y device-mapper dhcpcd dialog diffutils dmidecode dmraid dnscrypt-proxy
    sudo xbps-install -S -y dnssec-anchors dosfstools double-conversion dracut dropbox dtach
    sudo xbps-install -S -y dunst e2fsprogs e2fsprogs-libs efibootmgr electron13 elfutils-devel
    sudo xbps-install -S -y elogind emacs-common emacs-x11 enchant2 ethtool eudev eudev-libudev
    sudo xbps-install -S -y eudev-libudev-devel exempi exfat-utils exo expat expat-devel f2fs-tools
    sudo xbps-install -S -y faac faad2 faad2-devel faenza-icon-theme faience-icon-theme fcron fd
    sudo xbps-install -S -y fdk-aac ffmpeg ffmpegthumbnailer ffplay fftw-devel file file-roller
    sudo xbps-install -S -y findutils firefox-esr flite fltk font-alias font-b612 font-fira-ttf
    sudo xbps-install -S -y font-ibm-plex-ttf font-iosevka font-manjari font-material-design-icons-ttf
    sudo xbps-install -S -y font-misc-misc font-tamsyn font-util font-vollkorn-ttf fontconfig
    sudo xbps-install -S -y fontconfig-devel fontmanager fonts-croscore-ttf fonts-roboto-ttf
    sudo xbps-install -S -y freefont-ttf freetype freetype-devel fribidi fribidi-devel ftgl
    sudo xbps-install -S -y fuse fuse-sshfs fuse3 fzf fzy garcon gawk gc gcc gcompat gcompat-dbg
    sudo xbps-install -S -y gconf-editor gcr gd gdbm gdk-pixbuf gdk-pixbuf-devel gdk-pixbuf-xlib
    sudo xbps-install -S -y gettext gettext-dbg gettext-libs ghostwriter giflib gir-freedesktop gist
    sudo xbps-install -S -y git glances glew glew-devel glfw glfw-devel glib glib-dbg glib-devel
    sudo xbps-install -S -y glib-networking glibmm glibmm-devel glmark2 glslang glu glu-devel
    sudo xbps-install -S -y glxinfo gmime3 gmp gnome-disk-utility gnome-icon-theme gnome-keyring
    sudo xbps-install -S -y gnome-themes-extra gnome-themes-standard gnupg gnupg2 gnutls go
    sudo xbps-install -S -y goocanvas google-fonts-ttf gptfdisk graphene graphite graphite-devel
    sudo xbps-install -S -y grep grub grub-i386-efi grub-x86_64-efi gsettings-desktop-schemas
    sudo xbps-install -S -y gsfonts gspell gssdp gst-libav gst-plugins-bad1 gst-plugins-base1
    sudo xbps-install -S -y gst-plugins-good1 gst-plugins-ugly1 gstreamer1 gtk+ gtk+3 gtk+3-devel
    sudo xbps-install -S -y gtk-engine-murrine gtk-update-icon-cache gtkimageview gtkmm gtksourceview4
    sudo xbps-install -S -y guile gumbo-parser gupnp gupnp-igd gvfs gvfs-afc gvfs-afp gvfs-cdda
    sudo xbps-install -S -y gvfs-gphoto2 gvfs-mtp gvfs-smb gzip harfbuzz-devel hcxtools hddtemp
    sudo xbps-install -S -y hdparm hicolor-icon-theme hwids hxtools hyphen i3lock-color iana-etc
    sudo xbps-install -S -y iceauth icu-devel icu-libs imlib2 inetutils inetutils-dnsdomainname
    sudo xbps-install -S -y inetutils-ftp inetutils-hostname inetutils-ifconfig inetutils-inetd
    sudo xbps-install -S -y inetutils-ping inetutils-rexec inetutils-syslog inetutils-telnet
    sudo xbps-install -S -y inetutils-tftp inetutils-traceroute inetutils-uucpd inetutils-whois
    sudo xbps-install -S -y inih inxi iproute2 iptables iputils ipw2100-firmware ipw2200-firmware
    sudo xbps-install -S -y iso-codes iw jansson jbigkit-devel jbigkit-libs json-c json-glib jsoncpp
    sudo xbps-install -S -y kbd kernel-libc-headers keychain kitty kitty-terminfo kmod kpartx lame
    sudo xbps-install -S -y lcms2 lcms2-devel ldb less lgi libHX libICE libICE-devel libOSMesa
    sudo xbps-install -S -y libSM libSM-devel libX11 libX11-devel libXScrnSaver libXScrnSaver-devel
    sudo xbps-install -S -y libXau libXau-devel libXaw libXcomposite libXcomposite-devel libXcursor
    sudo xbps-install -S -y libXcursor-devel libXdamage libXdamage-devel libXdmcp libXdmcp-devel
    sudo xbps-install -S -y libXext libXext-devel libXfixes libXfixes-devel libXfont2 libXfontcache
    sudo xbps-install -S -y libXft libXft-devel libXi libXi-devel libXinerama libXinerama-devel
    sudo xbps-install -S -y libXmu libXpm libXpresent libXrandr libXrandr-devel libXrender
    sudo xbps-install -S -y libXrender-devel libXres libXt libXt-devel libXtst libXtst-devel libXv
    sudo xbps-install -S -y libXvMC libXxf86misc libXxf86vm libXxf86vm-devel liba52 libaio libao
    sudo xbps-install -S -y libaom libappindicator libarchive libargon2 libaspell libass libassuan
    sudo xbps-install -S -y libasyncns libatasmart libatomic libavcodec libavdevice libavfilter
    sudo xbps-install -S -y libavformat libavresample libavutil libblkid libblkid-devel libblockdev
    sudo xbps-install -S -y libbluray libboost_atomic1.72 libboost_chrono1.72 libboost_date_time1.72
    sudo xbps-install -S -y libboost_filesystem1.72 libboost_log1.72 libboost_program_options1.72
    sudo xbps-install -S -y libboost_regex1.72 libboost_thread1.72 libbs2b libbsd libbytesize libcaca
    sudo xbps-install -S -y libcaja libcaja-devel libcanberra libcanberra-gtk3 libcap libcap-ng
    sudo xbps-install -S -y libcap-progs libcddb libcdio libcdio-paranoia libcdparanoia libclang-cpp
    sudo xbps-install -S -y libclc libcolord libcracklib libcrypto1.1 libcryptsetup libcups libcurl
    sudo xbps-install -S -y libdatrie libdatrie-devel libdav1d4 libdaxctl libdb libdbusmenu-glib
    sudo xbps-install -S -y libdbusmenu-gtk3 libdca libde265 libdebuginfod libdecor libdjvulibre
    sudo xbps-install -S -y libdmx libdrm libdrm-devel libdvbpsi libdvdcss libdvdnav libdvdread
    sudo xbps-install -S -y libebml libedit libefivar libelf libelogind libepoxy libepoxy-devel libev
    sudo xbps-install -S -y libevdev libevdev-devel libevent libexecinfo libexif libfdisk libffi
    sudo xbps-install -S -y libffi-devel libfftw libfixposix libfixposix-dbg libflac libflac-devel
    sudo xbps-install -S -y libfluidsynth libfm-extra libfm-extra-devel libfontenc libfreeglut
    sudo xbps-install -S -y libgbm libgcc libgcc-devel libgcrypt libgirepository libglade libglapi
    sudo xbps-install -S -y libglib-devel libglvnd libglvnd-devel libgme libgnomekbd libgomp
    sudo xbps-install -S -y libgomp-devel libgpg-error libgpgme libgphoto2 libgphoto2-udev-rules
    sudo xbps-install -S -y libgs libgsf libgsm libgtop libgudev libgudev-devel libguile libgusb
    sudo xbps-install -S -y libhandy1 libharfbuzz libheif libhistory8 libhunspell1.7 libid3tag
    sudo xbps-install -S -y libidn2 libimobiledevice libindicator libinput libinput-devel libjack
    sudo xbps-install -S -y libjbig2dec libjpeg-turbo libjpeg-turbo-devel libkeyutils libkmod libksba
    sudo xbps-install -S -y libldap libldns liblightdm-gobject liblightdm-qt5 liblilv libllvm12
    sudo xbps-install -S -y liblrdf libltdl libltdl-devel libluv libluv-devel liblz4 liblzma
    sudo xbps-install -S -y liblzma-devel libmad libmagic libmagick libmagick-devel libmagick-perl
    sudo xbps-install -S -y libmanette libmatroska libmcpp libmd libmicrodns libsudo xbps-install -S -y mm-glib libmms
    sudo xbps-install -S -y libmnl libmnl-devel libmodplug libmount libmount-devel libmp3splt
    sudo xbps-install -S -y libmp4v2 libmp4v2-devel libmpcdec libmpdclient libmpeg2 libmpg123
    sudo xbps-install -S -y libmtp libnautilus libndctl libndp libnemo libnetfilter_conntrack
    sudo xbps-install -S -y libnfnetlink libnfs libnfsidmap libnftnl libnice libnih libnl3 libnm
    sudo xbps-install -S -y libnma libnotify libnotify-devel libnotmuch libnuma libnuspell libogg
    sudo xbps-install -S -y libogg-devel libopenal libopenjpeg2 libopenraw libopts libotf libpam-mount
    sudo xbps-install -S -y libpaper libparted libpcap libpciaccess libpciaccess-devel libpcre
    sudo xbps-install -S -y libpcre2 libpcrecpp libpeas libplacebo libplist libpng libpng-devel
    sudo xbps-install -S -y libpoppler libpostproc libprotobuf28 libprotobuf28-lite libproxy libpsl
    sudo xbps-install -S -y libpulseaudio libpwquality libpyldb-util libpytalloc-util libqalculate
    sudo xbps-install -S -y libraptor libreadline8 librsvg librtmp librubberband libsamplerate libsasl
    sudo xbps-install -S -y libsass libseccomp libsecret libsensors libserd libsigc++ libsigc++-devel
    sudo xbps-install -S -y libsmartcols libsndfile libsndfile-devel libsndio libsodium libsord
    sudo xbps-install -S -y libsoup libsoxr libspeex libsrtp libssh2 libssl1.1 libssp libssp-devel
    sudo xbps-install -S -y libstdc++ libstdc++-devel libswresample libswscale libtasn1 libtdb
    sudo xbps-install -S -y libthai libthai-devel libtheora libtirpc libtool libucontext libunbound
    sudo xbps-install -S -y libunistring libupnp libupower-glib3 libusb libusbmuxd libutempter
    sudo xbps-install -S -y libuuid libuuid-devel libuv libuv-devel libva libvamp-plugin-sdk
    sudo xbps-install -S -y libvdpau libvidstab libvisual libvlc libvoikko libvorbis libvorbis-devel
    sudo xbps-install -S -y libvpx6 libwacom libwacom-devel libwavpack libwebp libwmf libwnck
    sudo xbps-install -S -y libwoff2common1.0.2 libwoff2dec1.0.2 libwpe libxapian libxatracker libxbps
    sudo xbps-install -S -y libxcb libxcb-dbg libxcb-devel libxdg-basedir libxdg-basedir-devel
    sudo xbps-install -S -y libxfce4panel libxfce4ui libxfce4util libxkbcommon libxkbcommon-devel
    sudo xbps-install -S -y libxkbcommon-tools libxkbcommon-x11 libxkbfile libxkbregistry libxklavier
    sudo xbps-install -S -y libxml2 libxml2-devel libxshmfence libxshmfence-devel libxslt libxxHash
    sudo xbps-install -S -y libyaml libzbar libzip libzstd libzstd-devel lightdm lightdm-devel
    sudo xbps-install -S -y lightdm-gtk3-greeter linux linux-base linux-firmware linux-firmware-amd
    sudo xbps-install -S -y linux-firmware-broadcom linux-firmware-intel linux-firmware-network
    sudo xbps-install -S -y linux-firmware-nvidia linux5.13 live555 lm_sensors lmdb lnav lowdown
    sudo xbps-install -S -y lr lshw lsof lsscsi lua lua-devel lua-lpeg lua51 lua51-luasocket
    sudo xbps-install -S -y lua51-luasocket-dbg lua52 lua53 lua53-cjson lua53-devel lua53-lgi
    sudo xbps-install -S -y lua53-lpeg lua53-luaposix lua53-luaposix-dbg lua53-stdlib-debug
    sudo xbps-install -S -y lua53-stdlib-normalize luaposix luarocks luarocks-lua53 luasocket lvm2
    sudo xbps-install -S -y lxdm lzo lzo-devel m17n-db m17n-lib m4 make man-pages mate-desktop
    sudo xbps-install -S -y mate-icon-theme mcpp mdadm mdocml mesa mesa-XvMC mesa-dbg mesa-demos
    sudo xbps-install -S -y mesa-dri mesa-intel-dri mesa-nouveau-dri mesa-opencl mesa-vaapi mesa-vdpau
    sudo xbps-install -S -y mesa-vulkan-intel mesa-vulkan-overlay-layer mesa-vulkan-radeon micro
    sudo xbps-install -S -y minizip mit-krb5-libs mkfontscale mle mobile-broadband-provider-info
    sudo xbps-install -S -y mousepad mozjs78 mp3info-gtk mp3info-gtk-dbg mp3splt mp3splt-dbg
    sudo xbps-install -S -y mp3unicode mp3unicode-dbg mp3val mp3val-dbg mpfr mpg123-devel mpv
    sudo xbps-install -S -y mtdev mtdev-devel mupdf musl musl-devel musl-fts musl-obstack nano ncdu
    sudo xbps-install -S -y ncurses ncurses-base ncurses-devel ncurses-libs nemo nemo-fileroller
    sudo xbps-install -S -y nerd-fonts nerd-fonts-otf nerd-fonts-ttf nettle network-manager-applet
    sudo xbps-install -S -y newt nfs-utils nghttp2 nodejs noto-fonts-cjk noto-fonts-ttf npth nspr
    sudo xbps-install -S -y nss nsss ntfs-3g nvi ocl-icd oniguruma opendoas openresolv openssh
    sudo xbps-install -S -y openssl openssl-devel opus opus-devel opusfile opusfile-devel orc
    sudo xbps-install -S -y os-prober overpass-otf p11-kit p7zip pa-applet pam pam-base pam-devel
    sudo xbps-install -S -y pam-gnupg pam-libs pam-mount pam_wrapper pamixer pango pango-devel
    sudo xbps-install -S -y pango-xft pangomm papirus-icon-theme parole parted pciutils pcre-devel
    sudo xbps-install -S -y perl perl-Authen-SASL perl-Cairo perl-Cairo-GObject perl-Convert-BinHex
    sudo xbps-install -S -y perl-Curses perl-Digest-HMAC perl-ExtUtils-Depends perl-ExtUtils-PkgConfig
    sudo xbps-install -S -y perl-Glib perl-Glib-Object-Introspection perl-GooCanvas2 perl-Gtk3
    sudo xbps-install -S -y perl-IO-Socket-SSL perl-IO-stringy perl-Lchown perl-MIME-tools
    sudo xbps-install -S -y perl-MailTools perl-Module-Build perl-Net-SMTP-SSL perl-Net-SSLeay
    sudo xbps-install -S -y perl-Term-Animation perl-TimeDate perl-URI php php-imagick php-imagick-dbg
    sudo xbps-install -S -y pick pinentry pixman pixman-devel pkg-config polkit polybar poppler-data
    sudo xbps-install -S -y poppler-glib popt procps-ng psmisc pulseaudio pulseaudio-utils python3
    sudo xbps-install -S -y python3-BeautifulSoup4 python3-Pygments python3-Unidecode python3-cairo
    sudo xbps-install -S -y python3-charset-normalizer python3-colorama python3-commonmark
    sudo xbps-install -S -y python3-defusedxml python3-docopt python3-downloader-cli vpm vpsm vsv
    sudo xbps-install -S -y python3-ffmpeg-python python3-future python3-gobject python3-gpg
    sudo xbps-install -S -y python3-httpx python3-idna python3-itunespy python3-keyutils
    sudo xbps-install -S -y python3-llfuse python3-lxml python3-musicbrainzngs python3-mutagen
    sudo xbps-install -S -y python3-packaging python3-parsing python3-pip python3-psutil
    sudo xbps-install -S -y python3-pyDes python3-pycountry python3-pypamtest python3-pysocks
    sudo xbps-install -S -y python3-requests python3-rich python3-setuptools python3-simber
    sudo xbps-install -S -y python3-six python3-soupsieve python3-spotipy python3-typing_extensions
    sudo xbps-install -S -y python3-urllib3 python3-xdg python3-yaml python3-youtube-search
    sudo xbps-install -S -y python3-youtubesearch python3-ytmusicapi qalculate qt5-core qt5-dbus
    sudo xbps-install -S -y qt5-declarative qt5-gui qt5-location qt5-network qt5-printsupport
    sudo xbps-install -S -y qt5-sensors qt5-serialport qt5-sql qt5-svg qt5-test qt5-webchannel
    sudo xbps-install -S -y qt5-webengine qt5-webkit qt5-widgets qt5-x11extras qt5-xml ranger re2
    sudo xbps-install -S -y readline-devel recoll redshift redshift-gtk removed-packages rhash ripgrep
    sudo xbps-install -S -y nix ristretto rofi rofi-calc rpcbind rsnapshot rsync rtkit ruby run-parts
    sudo xbps-install -S -y runit runit-void sakura samba samba-libs sbc sed setxkbmap shaderc
    sudo xbps-install -S -y shadow shared-mime-info shellcheck signify skalibs slang smartmontools
    sudo xbps-install -S -y smplayer snappy sndio sndio-devel socklog socklog-void soundtouch sox
    sudo xbps-install -S -y spandsp spdx-licenses-list speexdsp sqlite sqlite-devel sratom starship
    sudo xbps-install -S -y startup startup-dbg startup-notification startup-notification-devel stdm
    sudo xbps-install -S -y stdm-dbg streamripper sudo sxiv taglib talloc tar termbox terminus-font
    sudo xbps-install -S -y tevent thin-provisioning-tools thunar-volman tiff tiff-devel tlp
    sudo xbps-install -S -y tolua traceroute tree tslib ttf-ubuntu-font-family tumbler twolame
    sudo xbps-install -S -y tzdata uchardet udiskie udisks2 unbound unrar unzip upower usbutils
    sudo xbps-install -S -y util-linux util-linux-common v4l-utils vim vim-common virglrenderer
    sudo xbps-install -S -y virglrenderer-dbg virglrenderer-devel vlc void-artwork void-docs
    sudo xbps-install -S -y void-docs-browse void-release-keys void-repo-debug void-repo-nonfree
    sudo xbps-install -S -y volume_key vscode vsv vte3 vulkan-loader w3m w3m-img w_scan wavpack-devel
    sudo xbps-install -S -y wayland wayland-devel wayland-protocols webkit2gtk webrtc-audio-processing
    sudo xbps-install -S -y wget which wifi-firmware wireless_tools wpa_supplicant wpebackend-fdo
    sudo xbps-install -S -y x264 x265 xapps xauth xbanish xbps xbps-triggers xcape xcb-imdkit
    sudo xbps-install -S -y xcb-imdkit-dbg xcb-proto xcb-util xcb-util-cursor xcb-util-cursor-dbg
    sudo xbps-install -S -y xcb-util-cursor-devel xcb-util-dbg xcb-util-devel xcb-util-errors
    sudo xbps-install -S -y xcb-util-errors-dbg xcb-util-image xcb-util-image-dbg xcb-util-image-devel
    sudo xbps-install -S -y xcb-util-keysyms xcb-util-keysyms-dbg xcb-util-keysyms-devel
    sudo xbps-install -S -y xcb-util-renderutil xcb-util-renderutil-dbg xcb-util-renderutil-devel
    sudo xbps-install -S -y xcb-util-wm xcb-util-wm-dbg xcb-util-wm-devel xcb-util-xrm
    sudo xbps-install -S -y xcb-util-xrm-dbg xcb-util-xrm-devel xclip xdg-dbus-proxy xdg-user-dirs
    sudo xbps-install -S -y xdg-user-dirs-gtk xdg-utils xdpyinfo xf86-input-evdev xf86-input-libinput
    sudo xbps-install -S -y xf86-input-synaptics xf86-input-vmmouse xf86-input-wacom xf86-video-amdgpu
    sudo xbps-install -S -y xf86-video-ati xf86-video-dummy xf86-video-fbdev xf86-video-intel
    sudo xbps-install -S -y xf86-video-nouveau xf86-video-vesa xf86-video-vmware xfce-polkit
    sudo xbps-install -S -y xfce4 xfce4-appfinder xfce4-notifyd xfce4-panel xfce4-power-manager
    sudo xbps-install -S -y xfce4-screensaver xfce4-session xfce4-settings xfce4-taskmanager
    sudo xbps-install -S -y xfce4-terminal xfconf xfdesktop xfsprogs xfwm4 xfwm4-themes xinit xkbcomp
    sudo xbps-install -S -y xkeyboard-config xmlcatmgr xorg-input-drivers xorg-minimal xorg-server
    sudo xbps-install -S -y xorg-server-common xorg-server-xephyr xorg-video-drivers xorgproto xprop
    sudo xbps-install -S -y xrandr xrdb xset xsetroot xterm xtools xtrans xvidcore xwallpaper xwininfo
    sudo xbps-install -S -y xxd xz yarn youtube-dl ytmdl zd1211-firmware zlib zlib-devel zsh zstd
    print s "###############################################################################"
    print s "Completed Package Installation"
    print s "###############################################################################"
}

## First Setup Needed Directories
mkdir -p ~/.config
mkdir -p ~/.local/share/bin

clonePackages() {
    print s "###############################################################################"
    print s "Git Cloning of Out-of-Repo Packages"
    print s "###############################################################################"
    # VPSM

    git clone git@github.com:the-Electric-Tantra-Linux/void-packages.git ~/.void-packages

    # XDEB
    git clone https://github.com/toluschr/xdeb $HOME/xdeb && cd $HOME/xdeb && sudo chmod 744 xdeb/xdeb && sudo mv xdeb/xdeb /usr/local/bin/ && rm xdeb

    # AwesomeWM
    git clone https://github.com/awesomewm/awesome $HOME/awesome && cd $HOME/awesome && sudo make && sudo make install && cd $HOME && rm -rvf $HOME/awesome

    # goautolock
    git clone https://gitlab.com/mrvik/goautolock $HOME/goautolock && cd $HOME/goautolock && sudo make && sudo make install && cd $HOME && rm -rvf $HOME/goautolock

    # greenclip
    sudo wget https://github.com/erebe/greenclip/releases/download/v4.2/greenclip /usr/bin/greenclip

    ## Void Glibc Container
    sudo mkdir -p /glibc
    sudo XBPS_ARCH=x86_64 xbps-install --repository=http://alpha.de.repo.voidlinux.org/current -r /glibc -S base-voidstrap
    git clone https://github.com/gch1p/voidnsrun $HOME/voidnsrun && cd voidnsrun && make run && sudo make install-run && cd $HOME && rm voidnsrun
    echo "export VOIDNSRUN_DIR=/glibc" >>.zshrc
    echo "export VOIDNSUNDO_BIN=/usr/local/bin/voidnsundo" >>~/.zshrc
    print s "###############################################################################"
    print s "Completed Git Cloning of Out-of-Repo Packages"
    print s "###############################################################################"

    # Nix
    sudo ln -s /etc/sv/nix-daemon /var/service
    source /etc/profile
    nix-channel --add https://nixos.org/channels/nixos-20.09 nixpkgs --remove nixos-20.09, --update
    
    # notes 
    curl -Ls https://raw.githubusercontent.com/pimterry/notes/latest-release/install.sh | sudo bash
}

installPackages
clonePackages
