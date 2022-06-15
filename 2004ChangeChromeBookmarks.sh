#!/usr/bin/env bash

# This script:
# 1. Creates folders in Google-chrome under .skjult user if not present
# 2. Add's bookmark file to the newly created folder
# 3. Set Bookmark Bar as either hidden or shown
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


BOOKMARK_FILE=$1
BOOKMARK_BAR=$2

mkdir -p /home/.skjult/.config/google-chrome
mkdir -p /home/.skjult/.config/google-chrome/Default/


if [ ! -f $BOOKMARK_FILE ]
then
    echo "No such file: $BOOKMARK_FILE"
    echo "Please supply a path to an existing bookmark file"
    exit -1
fi

# Overwrite default Bookmark file
BOOKMARK_FULL_PATH=/home/.skjult/.config/google-chrome/Default/Bookmarks
sudo /bin/cp -rf "$BOOKMARK_FILE"  "$BOOKMARK_FULL_PATH"

# Set Bookmark bar shown true/false

if [ "$BOOKMARK_BAR" = "True" ]; then
	touch /home/.skjult/.config/google-chrome/Default/Preferences
	echo '{"bookmark_bar":{"show_on_all_tabs":true}}' > /home/.skjult/.config/google-chrome/Default/Preferences
else
	echo '{"bookmark_bar":{"show_on_all_tabs":false}}' > /home/.skjult/.config/google-chrome/Default/Preferences
fi
exit 0
