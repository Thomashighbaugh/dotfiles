#!/usr/bin/env bash


####################################################################################
# rpi4-arch-install.sh
# --------------------
#
# Prepare an HD with ArchLinux ARM
#
####################################################################################


VERSION="0.2.0"


# Globals
##########
SCRIPT_DIR=$(dirname $(readlink -f $0));

ROOT_FS_BASE_URL="https://olegtown.pw/Public/ArchLinuxArm/RPi4/rootfs/"
KERNEL_BASE_URL="https://api.github.com/repos/sakaki-/bcm2711-kernel-bis/releases/latest"
RPI_FIRMWARE_GIT="https://github.com/raspberrypi/firmware.git" 

SUDO="sudo"

DEFAULT_PER_W=80
RES_OK="\xE2\x9C\x94"   #"\u2714";
RES_FAIL="\xE2\x9C\x96" #"\u2716";
RES_WARN="\xE2\x9A\xA0" #"\u2716";

RED="$(tput setaf 1)"
GREEN="$(tput setaf 2)"
YELLOW="$(tput setaf 3)"
BLUE="$(tput setaf 4)"
WHITE="$(tput setaf 7)"
BOLD="$(tput bold)"
NORMAL="$(tput sgr0)"

SAVE_CURSOR="$(tput sc)"
RESTORE_CURSOR="$(tput rc)"
CLEAR_TO_END="$(tput ed)"
MOVE_CURSOR_UP="$(tput cuu1)"
HIDE_CURSOR="$(tput civis)"
SHOW_CURSOR="$(tput cnorm)"

# Functions
###########

###################################
# Shows a heading section
# Params:
# - (1) section : Section's name
###################################
function showSection() {
	printf "\n\e[1;34m==> \e[1;37m$1\e[0m\n";
}

###################################
# Shows a sub section
# Params:
# - (1) subsection : Subsection's name
###################################
function showSubSection() {
	printf "\n\e[1;32m==> \e[1;37m$1\e[0m\n";
}

###################################
# Shows the result of an operation
###################################
function showResult() {
	local err=${1-$?};
	local msg=$2
	if [[ $err -eq 0 ]]; then
		success "$RES_OK";
		if [ -n "$msg" ]; then
			warn " $msg"
		fi
		printf "\n";
	else
		fail "$RES_FAIL\n";
	fi
}

###################################
# Shows the result of an operation
# and exit if return code not 0
###################################
function showResultOrExit() {
	local err=$?;
	local msg=$1;
	showResult "$err" "$msg";
	if [[ $err -ne 0 ]]; then
		if [ -n "$msg" ]; then
			fail "$msg\n";
		fi

		cleanup;
		exit -1;
	fi
}

#######################################
# Shows a success message (Green color)
# Params:
# - (1) msg : String to show
#######################################
function success() {
	printf "\e[0;32m$1\e[0m";
}

#######################################
# Shows a fail message (Red color)
# Params:
# - (1) msg : String to show
#######################################
function fail() {
	printf "\e[0;31m$1\e[0m";
}

#######################################
# Shows a debug message (Yellow color)
# Params:
# - (1) msg : String to show
#######################################
function debug() {
	printf "\e[0;33m$1\e[0m";
}

#######################################
# Shows a warning message (Yellow color)
# Params:
# - (1) msg : String to show
#######################################
function warn() {
	debug "$1"
}

##############################################
# Pads a message with the given character
# up to a maximum size,
# Params:
#   - (1) msg          : The message to pad
#   - (2) max_padding  : The maximum length to pad
#   - (3) padding_char : The character used in
#                        the padding.
##############################################
function paddingMax() {
	local msg=$1;
	local max_padding=$2;
	local padding_char=$3;
	local stripped_msg=$(stripAnsi "$msg");
	local cur_size=${#stripped_msg};

	while [ $cur_size -lt $max_padding ]; do
		let cur_size+=1;
		msg=${msg}${padding_char};
	done

	echo "$msg";
}

##############################################
# Pads a message with the given character
# up to the percentage of maximum terminal
# available width.
#
# params:
#   - (1) msg          : the message to pad
#   - (2) width_ratio  : the width percentage
#   - (3) padding_char : the character used in
#                        the padding.
##############################################
function padding() {
	local msg=$1;
	local width_ratio=$2;
	local padding_char=$3;
	local stripped_msg=$(stripAnsi "$msg");
	local cur_size=${#stripped_msg};
	local max_width=$(tput cols);
	local max_padding=$((max_width*width_ratio/100));

	while [ $cur_size -lt $max_padding ]; do
		let cur_size+=1;
		msg=${msg}${padding_char};
	done

	printf "$msg";
}

##############################################
# Pads a message with the given characters
# up to the percentage of maximum terminal
# available width.
#
# params:
#   - (1) msg          : the message to pad
##############################################
function pad() {
	padding "$1" $DEFAULT_PER_W '.';
}

##############################################
# Removes ANSI sequences from a given String
# Params:
# - (1) msg : String to remove ANSI sequences
##############################################
function stripAnsi() {
	echo -e $1 | sed "s,\x1B\[[0-9;]*[a-zA-Z],,g";
}

##############################################
# Moves the cursor to the maximum width
# in the current line
##############################################
function move_to_max_width() {
	max_width=$(tput cols);
	max_padding=$((max_width*$DEFAULT_PER_W/100));
	tput cuf $max_padding
}

##############################################
# Shows the help message
##############################################
function show_help() {
	debug "\nPayball's Rpi4 Automated Installer\n\n";
	printf "Usage : $(basename $0) <OPTIONS>\n";
	printf "where OPTIONS are :\n";
	printf "\t-d|--disk <disk>   : use the given disk (e.g. /dev/sdb)\n";
	printf "\t-k|--keep [<path>] : keep dowloaded files at this location\n";
	printf "\t-f|--from [<path>] : use dowloaded files at this location\n";
	printf "\t-h|--host [<host>] : set as hostname in target root file system\n";
	printf "\t-v                 : show version\n";
	printf "\t--help             : show this help\n";
}

##############################################
# Shows the version
##############################################
function show_version() {
	success "v$VERSION\n";
	exit 0;
}

##############################################
# Performs cleanup actions 
# - umount partitions
# - remove tmp directory
##############################################
function cleanup()  {
	if [ -d "$tmp_dir/boot" ]; then
		$SUDO umount $tmp_dir/boot &>/dev/null
	fi
	if [ -d "$tmp_dir/root" ]; then
		$SUDO umount $tmp_dir/root &>/dev/null
	fi
	if [ -d "$tmp_dir" ]; then
		rm -fr "$tmp_dir" &>/dev/null
	fi
}


#########s Main ###########

# Step 1 : Get args
disk="";
PARAMS=""

# Parse options
while (( "$#" )); do
	case "$1" in
		--help)
			show_help;
			exit 0;
			;;
		-v|--version)
			show_version;
			exit 0;
			;;
		-h|--host)
			host="$2";
			if [ -z "$host" ]; then
				fail "Hostname not specified";
				exit 1;
			fi
			shift 2
			;;
		-d|--disk)
			disk="$2"
			if [ -z "$disk" ]; then
				fail "Disk not specified";
				exit 1;
			fi
			shift 2;
			;;
		-k|--keep)
			target_folder="$2"
			if [ -z "$target_folder" ]; then
				fail "Download folder not specified";
				exit 1;
			fi
			shift 2;
			;;
		-f|--from)
			data_folder="$2"
			if [ -z "$data_folder" ]; then
				fail "Data folder not specified";
				exit 1;
			fi
			shift 2;
			;;
		--) # end argument parsing
			shift
			break
			;;
		*) # preserve positional arguments
			PARAMS="$PARAMS $1"
			shift
			;;
	esac
done

# set positional arguments in their proper place
eval set -- "$PARAMS"

if [ -n "$data_folder" -a ! -e "$data_folder" ]; then
	fail "Cannot access data folder \"$data_folder\"";
	exit 1
fi

if [ -n "$data_folder" ]; then
	if [ -n "$target_folder" ]; then
		fail "Cannot use target & source folder at the same time";
		exit 1;
	fi
	showSection "User options"
	warn "Using data folder [$data_folder]\n";
fi

if [ ! -b "$disk" ]; then
	fail "Cannot access disk \"$disk\"\n";
	exit 1;
fi

# Check disk is not main
if [[ $(df --output=source /) == *$disk* ]]; then
	fail "Cannot use main device \"$disk\"\n";
	exit 1;
fi

# Check if disk is mounted

if [[ $(lsblk $disk --output=mountpoint -n | grep -v "^$" | wc -l) -gt 0 ]]; then
	fail "Disk \"$disk\" is mounted\n";
	exit 1;
fi


# Step 2 : Check sudo permissions
if [ "$EUID" -ne 0 ]; then
	CAN_I_RUN_SUDO=$(sudo -n uptime 2>&1|grep "load"|wc -l)
	if [ ${CAN_I_RUN_SUDO} -eq 0 ]; then
		# Ask for the administrator password upfront
		warn "This script needs elevated permissions to execute.\nPlease provide super-user credentials to continue.\n"
		sudo -v
	fi
	# Keep-alive: update existing `sudo` time stamp until finished
	while true; do sudo -n true; sleep 62; kill -0 "$$" || exit; done 2>/dev/null &
else
	SUDO=""
fi

# Step 3 : Wipe all partitions
showSection "Disk preparation (\"$disk\")";

showSubSection "Creating partitions";

pad "Wiping disk";
$SUDO sfdisk --delete $disk -w always &>/dev/null
showResultOrExit;

pad "Creating boot partition"
echo ",204800,c" | $SUDO sfdisk /dev/sdb &>/dev/null
showResultOrExit;
pad "Creating root partition"
echo ",,83" | $SUDO sfdisk --append /dev/sdb &>/dev/null
showResultOrExit;

showSubSection "Formatting partitions"
pad "Wiping partition signatures"
$SUDO wipefs --all ${disk}1 &>/dev/null && $SUDO wipefs --all ${disk}2 &>/dev/null
showResultOrExit;
pad "Creating filesystems"
$SUDO mkfs.vfat -F 32 -n BOOT ${disk}1 &>/dev/null && $SUDO mkfs.ext4 ${disk}2 -L ROOT &>/dev/null
showResultOrExit;

showSubSection "Mounting partitions"
tmp_dir=$(mktemp -d -t rpi4_mnt-XXXXXXXXXX)
pad "Creating mount points"
mkdir -p $tmp_dir/{boot,root}
showResultOrExit

pad "Mounting \"$disk\" partitions"
$SUDO mount ${disk}1 $tmp_dir/boot &>/dev/null && $SUDO mount ${disk}2 $tmp_dir/root &>/dev/null
showResultOrExit

showSection "Root filesystem and kernel setup"

showSubSection "Extracting kernel & file system"

rfs_pack="";
if [ -z "$data_folder" ]; then
	pad "Downloading root filesystem"
	rfs_pack=$(curl -s $ROOT_FS_BASE_URL 2>/dev/null| sed -e "s;<a href;\n<a href;g" | grep "<a href" | cut -d"\"" -f2 | grep tar.gz | tail -1 | xargs -I{} basename {});
	if [ $? -ne 0 ]; then
		showResultOrExit
	fi
else
	pad "Retrieving root filesystem"
	ROOT_FS_BASE_URL=$data_folder;
	if [ -d "${data_folder}/root_fs" ]; then
		rfs_pack=$(find ${data_folder}/root_fs -type f -printf "%T@ %p\n" | sort -n | cut -d' ' -f 2- | tail -n 1)
	fi
	showResultOrExit
	ROOT_FS="${rfs_pack}";
fi

if [ -z "$rfs_pack" ]; then
	(exit 1);
	showResultOrExit "Cannot obtain latest root filesystem from $ROOT_FS_BASE_URL"
fi


if [ -z "$data_folder" ]; then
	DOWNLOAD_FOLDER="${tmp_dir}/root_fs"
	if [ -n "$target_folder" ]; then
		DOWNLOAD_FOLDER="$target_folder/root_fs";
	fi
	ROOT_FS="${DOWNLOAD_FOLDER}/$rfs_pack";
	printf "\n"
	warn "$(basename $ROOT_FS)\n"
	printf "$HIDE_CURSOR"
	$SUDO mkdir -p $DOWNLOAD_FOLDER && (cd $DOWNLOAD_FOLDER; $SUDO curl --progress-bar --remote-name --location $ROOT_FS_BASE_URL/$rfs_pack)
	printf "${MOVE_CURSOR_UP}${MOVE_CURSOR_UP}${CLEAR_TO_END}${MOVE_CURSOR_UP}${SHOW_CURSOR}"

	move_to_max_width;

	LAST_RC=$?

	(exit $LAST_RC)
	showResultOrExit
fi

pad "Extracting root file system"
if [ ! -e "$ROOT_FS" ]; then
	(exit 1);
	showResultOrExit "Root filesystem tarball not found"
fi
$SUDO bsdtar -xpf $ROOT_FS -C ${tmp_dir}/root &>/dev/null
showResultOrExit 

if [ -z "$data_folder" ]; then
	pad "Downloading Raspberry Pi 64bit kernel"
	kernel_url=$(curl -L -s $KERNEL_BASE_URL 2>/dev/null|  grep "browser_download" | cut -d"\"" -f4);
	if [ $? -ne 0 ]; then
		showResultOrExit
	fi

	if [ -z "$kernel_url" ]; then
		(exit 1);
		showResultOrExit "Cannot obtain latest kernel from $KERNEL_BASE_URL"
	fi

	KERNEL_DIR="$tmp_dir/kernel/";
	if [ -n "${target_folder}" ]; then
		KERNEL_DIR="${target_folder}/kernel";
	fi
	KERNEL_FILE="$(basename $kernel_url)";
	KERNEL="${KERNEL_DIR}/${KERNEL_FILE}";
	printf "\n"
	warn "$KERNEL_FILE\n"
	printf "$HIDE_CURSOR"
	$SUDO mkdir $KERNEL_DIR && (cd $KERNEL_DIR; $SUDO curl -L --progress-bar --remote-name --location $kernel_url)
	printf "${MOVE_CURSOR_UP}${MOVE_CURSOR_UP}${CLEAR_TO_END}${MOVE_CURSOR_UP}${MOVE_CURSOR_UP}${SHOW_CURSOR}"

	move_to_max_width;

	LAST_RC=$?

	(exit $LAST_RC)
	showResultOrExit
else
	pad "Retrieving kernel"
	kernel_pack="";
	if [ -d "${data_folder}/kernel" ]; then
		kernel_pack=$(find ${data_folder}/kernel -type f -printf "%T@ %p\n" | sort -n | cut -d' ' -f 2- | tail -n 1)
	fi
	KERNEL="${kernel_pack}"

	if [ ! -e "$KERNEL" ]; then
		(exit 1);
		showResultOrExit "Cannot obtain latest kernel from \"${data_folder}/kernel\"";

	fi
	showResultOrExit
fi

pad "Extracting kernel"
if [ ! -e "$KERNEL" ]; then
	(exit 1);
	showResultOrExit "Kernel tarball not found"
fi
$SUDO mkdir ${tmp_dir}/kernel_d && $SUDO bsdtar -xpf $KERNEL -C ${tmp_dir}/kernel_d &>/dev/null
showResultOrExit 

pad "Removing old kernel"
if [ ! -e "$tmp_dir/root/boot/config.txt" ]; then
	(exit 1);
	showResultOrExit "Kernel config file not found"
fi
old_kernel=$(grep "^kernel=" $tmp_dir/root/boot/config.txt | cut -d"=" -f2)
$SUDO rm -f $tmp_dir/root/boot/$old_kernel &> /dev/null
showResultOrExit

pad "Updating kernel config"
new_kernel=$(basename $(tar -tf $KERNEL| grep "boot" | grep "img$"));
$SUDO sed -i -e "s;^kernel=${old_kernel}$;kernel=${new_kernel};g" $tmp_dir/root/boot/config.txt &>/dev/null
showResultOrExit

pad "Merging kernel files"
$SUDO rsync -avzKP ${tmp_dir}/kernel_d/* ${tmp_dir}/root &>/dev/null
showResultOrExit

pad "Moving boot files to boot partition"
$SUDO mv $tmp_dir/root/boot/* $tmp_dir/boot/ &>/dev/null
showResultOrExit

showSubSection "Tuning user configuration"
pad "Configuring /etc/fstab"
echo "LABEL=BOOT  /boot    vfat   rw,relatime   0 0" | $SUDO tee $tmp_dir/root/etc/fstab &>/dev/null && \
       	echo "LABEL=ROOT  /        ext4   rw,relatime   0 1" | $SUDO tee -a $tmp_dir/root/etc/fstab &>/dev/null
showResultOrExit

pad "Updating /boot/cmdline.txt"
$SUDO perl -pi -e 's;^root=.+?[\s];root=LABEL=ROOT ;g' $tmp_dir/boot/cmdline.txt &>/dev/null
showResultOrExit

FIRM_DIR="${tmp_dir}/rpi_firmware"
if [ -z "${data_folder}" ]; then
	if [ -n "${target_folder}" ]; then
		FIRM_DIR="${target_folder}/rpi_firmware";
	fi
	pad "Downloading latest Raspberry Pi firmware"
	$SUDO git clone --depth 1 $RPI_FIRMWARE_GIT $FIRM_DIR &>/dev/null
	showResultOrExit
else
	pad "Retrieving Raspberry Pi firmware"
	FIRM_DIR="${data_folder}/rpi_firmware";
	if [ ! -d "${FIRM_DIR}/boot" ]; then
		(exit 1)
		showResultOrExit "Cannot find firmware boot files";
	else
		(exit 0)
		showResultOrExit
	fi
fi

pad "Copying firmware files"
$SUDO cp $FIRM_DIR/boot/{*.elf,*.dat} $tmp_dir/boot/ &>/dev/null
showResultOrExit

if [ -n "$host" ]; then
	pad "Setting hostname \"$host\""
	echo "$host" | $SUDO tee $tmp_dir/root/etc/hostname &>/dev/null
	showResultOrExit
fi

showSubSection "Performing cleanup"

pad "Unmounting disk \"$disk\""
$SUDO umount $tmp_dir/{boot,root}
showResultOrExit

pad "Removing temporary directory"
$SUDO rm -fr $tmp_dir;
showResultOrExit
