#!/usr/bin/env bash

# This script:
# 1. Creates "Skrivebord" folder if not found i .skjult user folder
# 2. Places defined file on Desktop
#
#
#
# Author: Benjamin Strüssmann Jensen


set -x

if [ $# -ne 2 ]
then
    echo "Usage: $(basename $0) {filename} "
    echo ""
    exit -1
fi

DESKTOP_FILE=$1
FILENAME=$2

DESKTOP_FULL_PATH="/home/.skjult/Skrivebord/$FILENAME"
mkdir --parents /home/.skjult/Skrivebord
sudo /bin/cp -rf "$DESKTOP_FILE"  "$DESKTOP_FULL_PATH"


