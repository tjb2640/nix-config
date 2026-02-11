#!/bin/sh

luksdevice="myfd"
username="$(whoami)"
mountpoint="/mnt/cryptdrive"
# links to $mountpoint/$username
linkat="/home/$username/CryptDrive"

if [ "$username" == "root" ]; then
    printf "This script should not be run as root\n"
    exit 1
fi

actionMountDrive() {
    printf "====================================\n"
    lsblk -Spyd --properties-by=file
    printf "====================================\n"

    read -p "Enter mount source (e.g. /dev/sdX): " dpath

    lsblk -nd -o PTTYPE -- "$dpath" 1> /dev/null 2>/dev/null
    if [ $? -eq 32 ]; then
        printf " --> $dpath is not a valid source\n"
        exit 1
    fi

    if ! [ -d "$mountpoint" ]; then
        printf "Need to mkdir the mount point at $mountpoint --\n"
        sudo mkdir -p -- "$mountpoint"
        if [ $? -ne 0 ]; then
            exit 1
        fi
    fi

    printf "(1/3) Open the LUKS device\n"
    sudo cryptsetup open -- "$dpath" "$luksdevice"

    printf "(2/3) Mount the encrypted partition\n"
    sudo mount -- "/dev/mapper/$luksdevice" "$mountpoint"
    
    userdrivedir="$mountpoint/$username"
    printf "(3/3) Set/check permissions for subdir $userdrivedir \n"
    sudo mkdir -p -- "$userdrivedir"
    sudo chown -- "$username" "$userdrivedir"
    sudo chmod 700 "$userdrivedir"

    if [ -L "$linkat" ]; then
        unlink "$linkat"
    fi
    ln -s "$userdrivedir" "$linkat"

    printf "Done! @ $linkat \n"
    exit 0
}

actionUnmountDrive() {
    printf "Unmounting $mountpoint ...\n"
    sudo umount -- "$mountpoint"
    printf "Closing device ...\n"
    sudo cryptsetup close -- "$luksdevice"
    printf "Cleaning up link ...\n"
    unlink "$linkat"
    printf "Done! You are free to remove the drive\n"
    exit 0
}

while getopts "mu" opt; do
    case "$opt" in
        m) actionMountDrive ;;
	u) actionUnmountDrive ;;
    esac
done

printf "Usage:\n"
printf " -m :: mount a drive\n"
printf " -u :: unmount the mounted drive\n"

