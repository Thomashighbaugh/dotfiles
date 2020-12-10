#!/usr/bin/env bash

SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPT_FILE="$(basename "${BASH_SOURCE[0]}")"
SCRIPT_NAME="${SCRIPT_FILE%.*}"

doPrintPrompt() {
    printf "[%s] $*" "$SCRIPT_NAME"
}

doPrint() {
    doPrintPrompt "$*\n"
}

doPrintHelpMessage() {
    printf "Usage: ./%s [-h] [-c config]\n" "$SCRIPT_FILE"
}

while getopts :hc: opt; do
    case "$opt" in
        h)
            doPrintHelpMessage
            exit 0
            ;;

        c)
            SCRIPT_CONF="$OPTARG"
            ;;

        :)
            printf "ERROR: "
            case "$OPTARG" in
                c)
                    printf "Missing config file"
                    ;;
            esac
            printf "\n"
            exit 1
            ;;

        \?)
            printf "ERROR: Invalid option ('-%s')\n" "$OPTARG"
            exit 1
            ;;
    esac
done
shift $((OPTIND - 1))

if [ -z "$SCRIPT_CONF" ]; then
    SCRIPT_CONF="$SCRIPT_PATH/$SCRIPT_NAME.conf"
fi

if [ ! -f "$SCRIPT_CONF" ]; then
    printf "ERROR: Config file not found ('%s')\n" "$SCRIPT_CONF"
    exit 1
fi

source "$SCRIPT_CONF"

# =================================================================================
#    F U N C T I O N S
# =================================================================================

doCheckRootPrivileges() {
    if [ "${USER}" != "root" ]; then
        printf "ERROR: This script requires root privileges\n"
        exit 1
    fi
}

doCheckInstallDevice() {
    if [ ! -b "$INSTALL_DEVICE" ]; then
        printf "ERROR: INSTALL_DEVICE is not a block device ('%s')\n" "$INSTALL_DEVICE"
        exit 1
    fi
}

doSelectHardwareModel() {
    local i=0

    if [ -z "$HARDWARE_MODEL_SELECT" ]; then
        doPrint "Select hardware model"

        local j=1
        while [ "$i" -lt "${#HARDWARE_MODEL[@]}" ]; do
            doPrint "$j = ${HARDWARE_MODEL[$i]}"
            let i=i+3
            let j=j+1
        done

        doPrintPrompt "> "
        read -r i
        if [[ ! $i =~ ^[0-9]+$ ]] || [ ! "$i" -gt "0" ] || [ ! "$i" -lt "$j" ]; then
            printf "ERROR: Invalid selection ('%s')\n" "$i"
            exit 1
        else
            HARDWARE_MODEL_SELECT="$i"
        fi
    fi

    let i=$HARDWARE_MODEL_SELECT*3-3
    doPrint "Installing for ${HARDWARE_MODEL[$i]}"

    let i=i+1
    ARCH_LINUX_DOWNLOAD_URL="${HARDWARE_MODEL[$i]}"

    let i=i+1
    ARCH_LINUX_PACKAGES_URL="${HARDWARE_MODEL[$i]}"
}

doConfirmInstall() {
    lsblk
    doPrint "Installing to '$INSTALL_DEVICE' - ALL DATA ON IT WILL BE LOST!"
    doPrint "Enter 'YES' (in capitals) to confirm and start the installation."

    doPrintPrompt "> "
    read -r i
    if [ "$i" != "YES" ]; then
        doPrint "Aborted."
        exit 0
    fi

    for i in {10..1}; do
        doPrint "Starting in $i - Press CTRL-C to abort..."
        sleep 1
    done
}

doDownloadArchLinux() {
    if [ ! -f "$(basename "$ARCH_LINUX_DOWNLOAD_URL")" ] || [ "$ARCH_LINUX_DOWNLOAD_FORCE" == "yes" ]; then
        rm -f "$(basename "$ARCH_LINUX_DOWNLOAD_URL")"
        curl --retry 999 --retry-delay 0 --retry-max-time 300 --speed-time 10 --speed-limit 0 \
            -LO "$ARCH_LINUX_DOWNLOAD_URL"
    fi
}

doGetAllPartitions() {
    lsblk -l -n -o NAME -x NAME "$INSTALL_DEVICE" | grep "^$INSTALL_DEVICE_FILE" | grep -v "^$INSTALL_DEVICE_FILE$"
}

doFlush() {
    sync
    sync
    sync
}

doWipeAllPartitions() {
    for i in $( doGetAllPartitions | sort -r ); do
        umount "$INSTALL_DEVICE_PATH/$i"
        dd if=/dev/zero of="$INSTALL_DEVICE_PATH/$i" bs=1M count=1
    done

    doFlush
}

doPartProbe() {
    partprobe "$INSTALL_DEVICE"
}

doWipeDevice() {
    dd if=/dev/zero of="$INSTALL_DEVICE" bs=1M count=1

    doFlush
    doPartProbe
}

doCreateNewPartitionTable() {
    parted -s -a optimal "$INSTALL_DEVICE" mklabel "$1"
}

doCreateNewPartitions() {
    local START="1"; local END="$BOOT_SIZE"
    case "$BOOT_FILESYSTEM" in
        fat32)
            parted -s -a optimal "$INSTALL_DEVICE" mkpart primary "$BOOT_FILESYSTEM" "${START}MiB" "${END}MiB"
            ;;

        *)
            parted -s -a optimal "$INSTALL_DEVICE" mkpart primary "${START}MiB" "${END}MiB"
            ;;
    esac

    START="$END"; END="100%"
    parted -s -a optimal "$INSTALL_DEVICE" mkpart primary "${START}MiB" "${END}MiB"

    parted -s -a optimal "$INSTALL_DEVICE" set 1 boot on

    doFlush
    doPartProbe
}

doDetectDevices() {
    local ALL_PARTITIONS=($( doGetAllPartitions ))

    BOOT_DEVICE="$INSTALL_DEVICE_PATH/${ALL_PARTITIONS[0]}"
    ROOT_DEVICE="$INSTALL_DEVICE_PATH/${ALL_PARTITIONS[1]}"
}

doMkfs() {
    case "$1" in
        fat32)
            mkfs -t fat -F 32 -n "$2" "$3"
            ;;

        *)
            mkfs -t "$1" -L "$2" "$3"
            ;;
    esac
}

doFormat() {
    doMkfs "$BOOT_FILESYSTEM" "$BOOT_LABEL" "$BOOT_DEVICE"
    doMkfs "$ROOT_FILESYSTEM" "$ROOT_LABEL" "$ROOT_DEVICE"
}

doMount() {
    mkdir -p root
    mount "$ROOT_DEVICE" root
    mkdir -p boot
    mount "$BOOT_DEVICE" boot
}

doUnpackArchLinux() {
    tar xvf "$(basename "$ARCH_LINUX_DOWNLOAD_URL")" -C root -p
}

doFinalizeBoot() {
    mv root/boot/* boot

    doFlush
}

doSetHostname() {
    cat > root/etc/hostname << __END__
$1
__END__
}

doSetTimezone() {
    ln -sf "/usr/share/zoneinfo/$1" root/etc/localtime
}

doSetConsole() {
    cat > root/etc/vconsole.conf << __END__
KEYMAP=$1
FONT=$2
__END__
}

doSetEthernetDhcp() {
    rm -f "root/etc/systemd/network/eth*.network"

    cat > "root/etc/systemd/network/$ETHERNET_INTERFACE.network" << __END__
[Match]
Name=$ETHERNET_INTERFACE

[Network]
DHCP=true
__END__

    if [ "$DISABLE_IPV6" == "yes" ]; then
        cat >> "root/etc/systemd/network/$ETHERNET_INTERFACE.network" << __END__
IPv6AcceptRouterAdvertisements=false
__END__
    fi
}

doSetEthernetStatic() {
    rm -f "root/etc/systemd/network/eth*.network"

    cat > "root/etc/systemd/network/$ETHERNET_INTERFACE.network" << __END__
[Match]
Name=$ETHERNET_INTERFACE

[Network]
DNS=$ETHERNET_DNS
__END__

    if [ "$DISABLE_IPV6" == "yes" ]; then
        cat >> "root/etc/systemd/network/$ETHERNET_INTERFACE.network" << __END__
IPv6AcceptRouterAdvertisements=false
__END__
    fi

    cat >> "root/etc/systemd/network/$ETHERNET_INTERFACE.network" << __END__

[Address]
Address=$ETHERNET_ADDRESS

[Route]
Gateway=$ETHERNET_GATEWAY
__END__
}

doSetWirelessDhcp() {
    cat > "root/etc/systemd/network/$WIRELESS_INTERFACE.network" << __END__
[Match]
Name=$WIRELESS_INTERFACE

[Network]
DHCP=true
__END__

    if [ "$DISABLE_IPV6" == "yes" ]; then
        cat >> "root/etc/systemd/network/$WIRELESS_INTERFACE.network" << __END__
IPv6AcceptRouterAdvertisements=false
__END__
    fi
}

doSetWirelessStatic() {
    cat > "root/etc/systemd/network/$WIRELESS_INTERFACE.network" << __END__
[Match]
Name=$WIRELESS_INTERFACE

[Network]
DNS=$WIRELESS_DNS
__END__

    if [ "$DISABLE_IPV6" == "yes" ]; then
        cat >> "root/etc/systemd/network/$WIRELESS_INTERFACE.network" << __END__
IPv6AcceptRouterAdvertisements=false
__END__
    fi

    cat >> "root/etc/systemd/network/$WIRELESS_INTERFACE.network" << __END__

[Address]
Address=$WIRELESS_ADDRESS

[Route]
Gateway=$WIRELESS_GATEWAY
__END__
}

doEnableWireless() {
    echo -n > "root/etc/wpa_supplicant/wpa_supplicant-$WIRELESS_INTERFACE.conf"

    if [ ! -z "$WIRELESS_COUNTRY" ]; then
        cat >> "root/etc/wpa_supplicant/wpa_supplicant-$WIRELESS_INTERFACE.conf" << __END__
country=$WIRELESS_COUNTRY
__END__
    fi

    cat >> "root/etc/wpa_supplicant/wpa_supplicant-$WIRELESS_INTERFACE.conf" << __END__
network={
    ssid="$WIRELESS_ESSID"
    psk="$WIRELESS_KEY"
__END__

    if [ "$WIRELESS_HIDDEN" == "yes" ]; then
        cat >> "root/etc/wpa_supplicant/wpa_supplicant-$WIRELESS_INTERFACE.conf" << __END__
    scan_ssid=1
__END__
    fi

    cat >> "root/etc/wpa_supplicant/wpa_supplicant-$WIRELESS_INTERFACE.conf" << __END__
}
__END__

    chmod 0640 "root/etc/wpa_supplicant/wpa_supplicant-$WIRELESS_INTERFACE.conf"

    ln -s "/usr/lib/systemd/system/wpa_supplicant@.service" "root/etc/systemd/system/multi-user.target.wants/wpa_supplicant@$WIRELESS_INTERFACE.service"
}

doDisableIpv6() {
    cat > root/etc/sysctl.d/40-ipv6.conf << __END__
ipv6.disable_ipv6=1
__END__
}

doBashLogoutClear() {
    cat >> root/root/.bash_logout << __END__
clear
__END__
}

doSshAcceptKeyTypeSshDss() {
    cat >> root/etc/ssh/ssh_config << __END__
Host *
  PubkeyAcceptedKeyTypes=+ssh-dss
__END__

    cat >> root/etc/ssh/sshd_config << __END__
PubkeyAcceptedKeyTypes=+ssh-dss
__END__
}

doCreateYayDirectory() {
    local DIR="root$(eval printf "$YAY_PATH")"
    mkdir -p "$DIR"
}

doChmodYayDirectory() {
    if [ ! -z "$YAY_CHXXX_PATH" ]; then
        local DIR="root$(eval printf "$YAY_CHXXX_PATH")"
        if [ ! -z "$YAY_CHMOD" ]; then
            chmod -R "$YAY_CHMOD" "$DIR"
        fi
    fi
}

doChownYayDirectory() {
    if [ ! -z "$YAY_CHXXX_PATH" ]; then
        local DIR="root$(eval printf "$YAY_CHXXX_PATH")"
        if [ ! -z "$YAY_CHOWN" ]; then
            chown -R "$YAY_CHOWN" "$DIR"
        fi
    fi
}

doDownloadYay() {
    doCreateYayDirectory
    doChmodYayDirectory

    local _PWD="$PWD"

    local DIR="root$(eval printf "$YAY_PATH")"
    cd "$DIR"

    local URL="$YAY_YAY_URL"
    curl --retry 999 --retry-delay 0 --retry-max-time 300 --speed-time 10 --speed-limit 0 \
        -LO "$URL"

    cd "$_PWD"

    doChownYayDirectory
}


doSymlinkHashCommands() {
    ln -s /usr/bin/md5sum root/usr/local/bin/md5
    ln -s /usr/bin/sha1sum root/usr/local/bin/sha1
}

doOptimizeSwappiness() {
    cat > root/etc/sysctl.d/99-sysctl.conf << __END__
vm.swappiness=$OPTIMIZE_SWAPPINESS_VALUE
__END__
}

doCreatePackageSetsDirectory() {
    local DIR="root$(eval printf "$PACKAGE_SETS_PATH")"
    mkdir -p "$DIR"
}

doDownloadPackage() {
    local REPOSITORY="$(printf "$2" | cut -d/ -f1)"
    local PACKAGE_NAME="$(printf "$2" | cut -d/ -f2)"

    local PACKAGE_FILE="$(curl -sL "$ARCH_LINUX_PACKAGES_URL$REPOSITORY" | sed -e 's/<[^>]*>/ /g' | grep "$PACKAGE_NAME-.*xz[^.]" | awk '{ print $1 }')"
    local PACKAGE_URL="$ARCH_LINUX_PACKAGES_URL$REPOSITORY/$PACKAGE_FILE"

    doPrint ">>> [$1] $REPOSITORY/$PACKAGE_NAME ($PACKAGE_URL)"

    doCreatePackageSetsDirectory

    local _PWD="$PWD"

    local DIR="root$(eval printf "$PACKAGE_SETS_PATH")"
    cd "$DIR"

    curl --retry 999 --retry-delay 0 --retry-max-time 300 --speed-time 10 --speed-limit 0 \
        -LO "$PACKAGE_URL"

    cd "$_PWD"
}

doDownloadPackageSets() {
    doPrint "Downloading package sets..."
    for i in $DOWNLOAD_PACKAGE_SETS; do
        for j in ${PACKAGE_SET[$i]}; do
            doDownloadPackage "$i" "$j"
        done
    done
}

doUnmount() {
    umount "$BOOT_DEVICE"
    rmdir boot

    umount "$ROOT_DEVICE"
    rmdir root
}

# =================================================================================
#    M A I N
# =================================================================================

doCheckRootPrivileges

doCheckInstallDevice

doSelectHardwareModel

doConfirmInstall

doDownloadArchLinux

doWipeAllPartitions
doWipeDevice

doCreateNewPartitionTable "$PARTITION_TABLE_TYPE"

doCreateNewPartitions
doDetectDevices

doFormat
doMount

doUnpackArchLinux

doFinalizeBoot

doSetHostname "$HOSTNAME"
doSetTimezone "$TIMEZONE"

doSetConsole "$CONSOLE_KEYMAP" "$CONSOLE_FONT"

if [ "$SET_ETHERNET" == "yes" ]; then
    if [ "$ETHERNET_DHCP" == "no" ]; then
        doSetEthernetStatic
    else
        doSetEthernetDhcp
    fi
fi

if [ "$SET_WIRELESS" == "yes" ]; then
    if [ "$WIRELESS_DHCP" == "no" ]; then
        doSetWirelessStatic
    else
        doSetWirelessDhcp
    fi

    doEnableWireless
fi

[ "$DISABLE_IPV6" == "yes" ] && doDisableIpv6

[ "$ROOT_USER_BASH_LOGOUT_CLEAR" == "yes" ] && doBashLogoutClear

[ "$SSH_ACCEPT_KEY_TYPE_SSH_DSS" == "yes" ] && doSshAcceptKeyTypeSshDss

[ "$DOWNLOAD_YAY" == "yes" ] && doDownloadYay

[ "$SYMLINK_HASH_COMMANDS" == "yes" ] && doSymlinkHashCommands

[ "$OPTIMIZE_SWAPPINESS" == "yes" ] && doOptimizeSwappiness

[ ! -z "$DOWNLOAD_PACKAGE_SETS" ] && doDownloadPackageSets

doPrint "Flushing..."
doFlush

doUnmount

doPrint "The installation is done!"

exit 0
