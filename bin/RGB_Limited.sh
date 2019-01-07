#!/bin/bash
# Enable limited RGB range 16..235 on Intel HD

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

intel_reg write 0x70008 0xC0000000
intel_reg write 0x70180 0xD8004400

xrandr --output HDMI1 --set "Broadcast RGB" "Limited 16:235"
