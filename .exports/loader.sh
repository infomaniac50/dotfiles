#!/usr/bin/env bash
# vim:set filetype=sh:

command_exists()
{
    hash "$1" 2>/dev/null
    return $?
}

function loader_load
{
  if [[ -z $1 ]]; then
    return 1;
  fi

  local file="${HOME}/.exports/$1.sh"

  if [[ -e $file ]]; then
    . $file
  fi
}

function loader
{
  if [[ $# -eq 0 ]]; then
    echo "At least one loader script argument is required."
    return 1;
  fi

  local file

  case "$1" in
    "list" )
      for file in ${HOME}/.exports/*.sh; do
        basename ${file%%.sh}
      done
      return 0
      ;;
    "load" )
      for file in "$@"; do
        loader_load $file
      done
      return 0
      ;;
  esac
}

function loaderctl()
{
  local configdir=${HOME}/.loaderctl

  local service=$1
  local action=$2
  local scriptfile=$configdir/$service-$action.sh
  local pwdstate=$PWD
  if [ -r $scriptfile ]; then
    source $scriptfile
  fi
  cd $pwdstate
}
