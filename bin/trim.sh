#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

# The offset, length, and minimum-free-extent arguments may be followed by binary (2^N) suffixes KiB, MiB, GiB, TiB, PiB and EiB (the "iB" is optional, e.g. "K" has the same meaning as "KiB") or decimal (10^N) suffixes KB, MB, GB, PB and EB.
# -h, --help
#    Print help and exit.
# -o, --offset offset
#    Byte offset in filesystem from which to begin searching for free blocks to discard. Default value is zero, starting at the beginning of the filesystem.
# -l, --length length
#    Number of bytes after starting point to search for free blocks to discard. If the specified value extends past the end of the filesystem, fstrim will stop at the filesystem size boundary. Default value extends to the end of the filesystem.
# -m, --minimum minimum-free-extent
#    Minimum contiguous free range to discard, in bytes. (This value is internally rounded up to a multiple of the filesystem block size). Free ranges smaller than this will be ignored. By increasing this value, the fstrim operation will complete more quickly for filesystems with badly fragmented freespace, although not all blocks will be discarded. Default value is zero, discard every free block.
# -v, --verbose
#    Verbose execution. When specified fstrim will output the number of bytes passed from the filesystem down the block stack to the device for potential discard. This number is a maximum discard amount from the storage device's perspective, because FITRIM ioctl called repeated will keep sending the same sectors for discard repeatedly.
#    fstrim will report the same potential discard bytes each time, but only sectors which had been written to between the discards would actually be discarded by the storage device. Further, the kernel block layer reserves the right to adjust the discard ranges to fit raid stripe geometry, non-trim capable devices in a LVM setup, etc. These reductions would not be reflected in fstrim_range.len (the --length option).

# Print all commands like a Makefile does
set -x

# Write everything to disk before starting fstrim.
sync
# I'm not sure sync is enough for btrfs.
btrfs filesystem sync /data

# Limiting discard length to 1 megabyte speeds up the trim and reduces wear a little bit.
fstrim --minimum 1MiB --verbose /
fstrim --minimum 1MiB --verbose /home
fstrim --minimum 1MiB --verbose /data
