#!/bin/sh

luksdevicename="cryptdriveflash"
username="$(whoami)"
mountpoint="/mnt/__cryptdrive"
userdrivedir="$mountpoint/$username"
# links to $userdrivedir
linkat="/home/$username/CryptDrive"

if [ "root" == "$username" ]; then
    printf "Do not run this script with root permissions.\n"
    exit 1
fi

printbar() {
    printf "=========================================\n"
}

step() {
    printf -- "\n --> $1 ... \n"
}

confirmation=""
promptConfirmAction() {
    confirmation=""
    printf "\n"
    printbar
    printf "Type 'i am sure' in ALL CAPS to continue.\n"
    printbar
    printf "\n"
    read -p "Type here and hit enter: " confirmation
    if [ "$confirmation" != "I AM SURE" ]; then
        promptConfirmAction
    fi
}

dpath=""
promptSelectDevice() {
    dpath=""
    printf "\n"
    printbar
    printf "Please select the correct block.\n"
    printbar

    # A little more useful information here when retrieving by file
    lsblk -Spyd --properties-by=file
    printbar
    read -p "Enter mount source (e.g. /dev/sdX): " dpath

    if [ "" == "$dpath" ]; then
        printf "Please enter a valid block, e.g. /dev/sdX \n"
        promptSelectDevice
    fi

    lsblk -nd -o PTTYPE -- "$dpath" 1> /dev/null 2>/dev/null
    if [ $? -eq 32 ]; then
        printf "'$dpath' is not a valid block!\n"
        promptSelectDevice
    fi
}

actionFormatDrive() {
    printf "\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
    printf "!! FAIR WARNING!!                                         !!\n"
    printf "!! By continuing you understand that this will completely !!\n"
    printf "!! wipe the data from the selected block and format the   !!\n"
    printf "!! device entirely. This will overwrite all data on the   !!\n"
    printf "!! selected device. This action is destructive.           !!\n"
    printf "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
    promptConfirmAction
    promptSelectDevice

    # Format drive
    printf "\n!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
    printf "!! Please confirm this looks like the correct command+path !!\n"
    printf "!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!\n"
    printf "\n# cryptsetup luksFormat -- $dpath \n"
    promptConfirmAction

    step "luksFormat $dpath"
    sudo cryptsetup luksFormat -- "$dpath"

    step "luksOpen $dpath"
    sudo cryptsetup luksOpen -- "$dpath" "$luksdevicename"

    step "create EXT4 partition"
    sudo mkfs.ext4 -- "/dev/mapper/$luksdevicename"

    step "close LUKS device $luksdevicename"
    sudo cryptsetup close -- "$luksdevicename"

    printf "\nDone! Run this script with the -m flag to mount the device.\n"
    exit 0
}

actionMountDrive() {
    promptSelectDevice

    if ! [ -d "$mountpoint" ]; then
        step "mkdir the mount point at $mountpoint"
        sudo mkdir -p -- "$mountpoint"
        if [ $? -ne 0 ]; then
            exit 1
        fi
    fi

    step "open the LUKS device"
    sudo cryptsetup open -- "$dpath" "$luksdevicename"

    step "mount the encrypted partition"
    sudo mount -- "/dev/mapper/$luksdevicename" "$mountpoint"
    
    step "set/check permissions for subdir $userdrivedir"
    sudo mkdir -p -- "$userdrivedir"
    sudo chown -- "$username" "$userdrivedir"
    sudo chmod 700 -- "$userdrivedir"

    if [ -L "$linkat" ]; then
        unlink -- "$linkat"
    fi
    ln -s -- "$userdrivedir" "$linkat"

    printf "Done - mounted drive at $linkat \n"
    exit 0
}

actionUnmountDrive() {
    step "unmount $mountpoint"
    sudo umount -- "$mountpoint"

    if [ -L "$linkat" ]; then
        step "clean up dead link at $linkat"
        unlink -- "$linkat"
    fi

    step "close LUKS device '$luksdevicename'"
    sudo cryptsetup close -- "$luksdevicename"

    printf "Done! You are free to remove the drive\n"
    exit 0
}

while getopts "fmu" opt; do
    case "$opt" in
        f) actionFormatDrive ;;
        m) actionMountDrive ;;
        u) actionUnmountDrive ;;
    esac
done

printf "Usage:\n"
printf " -f :: LUKS encrypt a drive and create an EXT4 partition inside it\n"
printf " -m :: mount an encrypted drive\n"
printf " -u :: unmount the mounted encrypted drive\n"
