#!/usr/bin/env bash
# vim:set filetype=sh:

if [[ -d $PWD/bin ]]; then
  pathprepend $PWD/bin PATH
fi
