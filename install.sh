#!/bin/bash

# System Management tools
emerge --ask sys-fs/e2fsprogs sys-apps/mlocate sys-process/cronie app-admin/logrotate app-admin/sysklogd

emerge --ask --noreplace net-misc/netifrc

# Wireless tools
emerge --ask net-wireless/iw net-misc/dhcpcd dhcpcd-ui wpa_supplicant

# Network Management with dhcpcd
rc-update add dhcpcd default
/etc/init.d/dhcpcd start 
rc-update add wpa_supplicantd default
/etc/init.d/wpa_supplicant start

# xfce GUI
emerge x11-base/xorg-server xfce-base/xfce4-meta xfce-extra/xfce4-notifyd x11-misc/lightdm xfce-extra/thunar-archive-plugin xfce4-pulseaudio-plugin xfdashboard xfce4-taskmanager xfce4-weather-plugin

# Basic tools
emerge --ask sudo htop terminator neofetch xarchiver firefox geany media-fonts/powerline-symbols openvpn

# Audio
emerge --ask media-sound/alsa-utils media-sound/pavucontrol paprefs

# Bluetooth
emerge --ask --noreplace net-wireless/bluez
rc-service bluetooth start
rc-update add bluetooth default

# Network Print
emerge --ask net-print/cups net-fs/samba
rc-service cupsd start
rc-update add cupsd default

# Build tools
emerge --ask net-libs/libmicrohttpd cmake hwloc msr-tools numactl

# Add user permissions
usermod -a -G adm,lpadmin,lp,wheel,audio,video $USER

# Update system
emerge --sync
emerge -uDU --keep-going --with-bdeps=y @world
