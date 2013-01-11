#!/bin/sh
SCRIPT_NAME=`basename $0`
if [ -z "$1" ]; then
    echo "Usage: $SCRIPT_NAME file.pic"
else
    pic $1 | groff > /tmp/output.ps && ps2epsi /tmp/output.ps /tmp/output2.ps && convert -resize 9% -density 1152 /tmp/output2.ps /tmp/output.png && firefox /tmp/output.png
fi
