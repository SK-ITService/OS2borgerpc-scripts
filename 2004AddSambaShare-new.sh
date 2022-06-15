#!/usr/bin/env bash

# This script:
# 1. Install Samba & CIFS-Utils
# 2. Add "user" to Samba
# 3. Check if settings are set in smb.conf else set it
#
# Author: Benjamin Strüssmann Jensen

set -x

PASSWORD=$1

if [ $# -ne 1 ]
then
    echo "Angiv venligst et Password"
    echo ""
    exit -1
fi

export DEBIAN_FRONTEND=noninteractive

apt-get update --assume-yes
apt-get install --assume-yes samba 
apt-get install --assume-yes cifs-utils

# Create the samba user and set password for user "user"
# If samba-user is already created this is just a password reset
echo -ne "$PASSWORD\n$PASSWORD\n" | smbpasswd -a -s user

# Make a backup if a backup does not already exist
cp -n /etc/samba/smb.conf /etc/samba/smb.conf.orig || true

# Append network share config to smb.conf if not already in place
if grep "Skrivebord" /etc/samba/smb.conf; then
    echo "Settings already in place"
else
    cat >> /etc/samba/smb.conf <<- EOF
[Skrivebord]
comment = Shared Desktop folder
path = /home/user/Skrivebord
read only = no
guest ok = no
valid users = user
writeable = yes
write list = user
EOF
echo "Settings added"
fi


# Restart samba
systemctl restart smbd

exit 0

