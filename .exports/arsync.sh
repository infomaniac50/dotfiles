#!/usr/bin/env bash

# Archival rsync
arsync() { rsync --recursive --links --perms --devices --specials --times --protect-args --human-readable --partial --progress --itemize-changes --stats "$@"; }
