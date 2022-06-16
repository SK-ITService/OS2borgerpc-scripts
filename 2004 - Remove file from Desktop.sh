#!/usr/bin/env bash

# This script:
# 1. Deletes named file from .skjult Desktop
#
#
#
# Author: Benjamin Strüssmann Jensen


set -x

FILENAME=$1

DESKTOP_FULL_PATH=/home/.skjult/Skrivebord
rm -f "$DESKTOP_FULL_PATH/$FILENAME"

