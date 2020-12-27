#!/bin/bash

# Copyright © Mardan . All Rights Reserved.
:<<Comments 代码说明
这是一个whiptail实例
仅限linux
Comments

#! /bin/bash --posix
ROOTFILE=`ls /`

if [ $(id -u) -ne 0 ]; then
    echo -e "\033[36mScript must be run as root\033[0m\n"
  exit 1
fi

do_ifconfig() {
  whiptail --msgbox "this is static text" 20 60 1
}

do_passwd() {
	PASSWORD=$(whiptail --title "Password Box" --passwordbox "Enter your password and choose Ok to continue." 10 60 3>&1 1>&2 2>&3)
	echo $PASSWORD
}

do_show_rootfs() {
	whiptail --title "Show root file" --msgbox "${ROOTFILE}" 20 60 1
}

while true; do
  FUN=$(whiptail --menu "418 tools for UNIX" 20 80 10 --cancel-button Exit \
    "ifconfig" "ifconfig" \
    "passwd" "Get password test" \
    "show_rootfs" "Show root partition file tree" \
    "overscan" "Change overscan (error test)" \
    3>&1 1>&2 2>&3)
  if [ $? -ne 0 ]; then
    exit 1;
  else
    "do_$FUN" || whiptail --msgbox "There was an error running do_$FUN" 20 60 1
  fi
done