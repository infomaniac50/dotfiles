#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

set -x

# Remove all cached versions of aura packages, except for the most recent 2.
aura -Cc 2

# Remove all cached versions of installed and uninstalled packages, except for the most recent 2.
paccache -rk2

# Remove all cached versions of uninstalled packages.
paccache -ruk0
