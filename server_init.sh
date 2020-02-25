#!/bin/bash

red='\e[1;31m%s\e[0m\n'
cyan='\e[1;36m%s\e[0m\n'
green='\e[1;32m%s\e[0m\n'
yellow='\e[1;33m%s\e[0m\n'

printf "\n"
printf "$green" "                     _                                   "
printf "$green" "                    (_)                                  "
printf "$green" " _ __ ___  _   _ ___ _  ___ ___  ___ _ ____   _____ _ __ "
printf "$green" "|  '_ \` _ | | | / __| |/ __/ __|/ _ \ '__\ \ / / _ \ '__|"
printf "$green" "| | | | | | |_| \__ \ | (__\__ \  __/ |   \ V /  __/ |   "
printf "$green" "|_| |_| |_|\__,_|___/_|\___|___/\___|_|    \_/ \___|_|   "

if [ $# -eq 0 ]; then
    printf "\nPlease supply the path to the uninitialized music_storage volume."
    printf "\n$yellow"    "e.g.\n\$>server_init.sh /dev/nvme1n1"
    printf "\nTo find this volume, run df and lsblk, and identify the volume not in use."
    printf "\nOn Ubuntu in AWS, it will commonly be named nvme1n#."
    printf "\n\n$red"   "MAKE SURE you do not supply the root volume block device!"
    exit 1
fi

if [ -b $1 ]; then
    printf "You have selected $1 for initialization as the music_storage volume."
else
    printf "\n$red" "$1 is NOT a valid block device!"
    exit 1
fi
