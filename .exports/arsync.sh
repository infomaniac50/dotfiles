#!/usr/bin/env bash
# vim:set filetype=sh:

# Archival rsync
arsync() { rsync --recursive --links --perms --devices --specials --times --protect-args --human-readable --partial --progress --itemize-changes --stats "$@"; }
