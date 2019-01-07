#!/bin/bash
# Enable full RGB range 0..255 on Intel HD

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

xrandr --output HDMI1 --set "Broadcast RGB" "Limited 16:235"

intel_reg write 0x70008 0xC4002000
intel_reg write 0x70180 0xDA004400

xrandr --output HDMI1 --set "Broadcast RGB" "Full"

intel_reg write 0x70180 0xDA004400

