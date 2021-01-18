#!/bin/bash

# System Management tools
emerge --ask sys-fs/e2fsprogs sys-apps/mlocate sys-process/cronie app-admin/logrotate app-admin/sysklogd

emerge --ask --noreplace net-misc/netifrc

# Wireless tools
emerge --ask net-wireless/iw net-misc/dhcpcd dhcpcd-ui wpa_supplicant net-misc/networkmanager net-vpn/networkmanager-openvpn

# remove any netifrc scripts from controlling network interfaces
for x in /etc/runlevels/default/net.* ; do rc-update del $(basename $x) default ; rc-service --ifstarted $(basename $x) stop; done

# Network mangement with NetworkManager
rc-update add NetworkManager default
rc-service NetworkManager start

# Network Management with dhcpcd
#rc-update add dhcpcd default
#/etc/init.d/dhcpcd start 
#rc-update add wpa_supplicantd default
#/etc/init.d/wpa_supplicant start

# Remove network management with dhcpcd
#rc-update del dhcpcd default
#rc-update del wpa_supplicant default

# X Server
emerge x11-base/xorg-server 

# LightDM
#x11-misc/lightdm

# Start LightDM on boot
#rc-update add dbus default
#rc-update add xdm default

# DWM
emerge --ask x11-libs/libXft media-fonts/hack x11-misc/stalonetray x11-misc/picom x11-apps/xrandr x11-apps/xsetroot x11-misc/nitrogen gnome-extra/nm-applet

# Fix locale for dmenu
echo "LC_ALL=en_US.UTF-8" >> /etc/env.d/02locale

# xfce GUI
#xfce-base/xfce4-meta xfce-extra/xfce4-notifyd xfce-extra/thunar-archive-plugin xfce4-pulseaudio-plugin xfdashboard xfce4-taskmanager xfce4-weather-plugin

#Edit /etc/portage/package.use
echo "media-plugins/alsa-plugins pulseaudio" >> /etc/portage/package.use/alsa-plugins
echo "media-libs/libvpx postproc" >> /etc/portage/package.use/libvpx
echo "www-client/w3m imlib" >> /etc/portage/package.use/w3m

# Basic tools
emerge --ask sudo htop terminator lxterminal neofetch spacefm xarchiver firefox geany media-fonts/powerline-symbols openvpn dev-vcs/git

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

# Remove passwd restriction (may need to #comment out existing 'password' lines)
echo "#password	required	pam_cracklib.so difok=2 minlen=8 dcredit=2 ocredit=2 retry=3" >> /etc/pam.d/passwd
echo "#password	required	pam_unix.so sha512 shadow use_authtok" >> /etc/pam.d/passwd
echo "password	required	pam_unix.so sha512 shadow nullok" >> /etc/pam.d/passwd

# Update system
emerge --sync
emerge -uDU --keep-going --with-bdeps=y @world
