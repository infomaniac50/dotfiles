#!/usr/bin/env bash
# vim:set filetype=sh:

command_exists()
{
    hash "$1" 2>/dev/null
    return $?
}

function loader_dependsAll
{
  local script
  local exportName="LOADER_DEPENDS_${script^^}"
  exportName="${exportName//[- ]/_}"

  for script in "$@"; do
    if [[ $$exportName -ne 1 ]]; then
      loader_load "$script"
    fi
  done

  return $?
}

function loader_load
{
  local file="${HOME}/.exports/$1.sh"
  local exportName="LOADER_DEPENDS_${script^^}"
  exportName="${exportName//[- ]/_}"

  if [[ -e "$file" ]]; then
    export $exportName=1
    . "$file"
  fi

  return $?
}

function loader_loadAll
{
  local script

  for script in "$@"; do
    loader_load "$script"
  done

  return $?
}

function loader_show
{
  local script="$1"
  local file="${HOME}/.exports/$script.sh"

  if [[ -e "$file" ]]; then
    cat "$file"
  fi

  return $?
}

function loader_list
{
  local scripts="${HOME}/.exports/*.sh"
  local script

  for script in $scripts; do
    basename ${script%%.sh}
  done

  return $?
}

function loader_service()
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

function loader
{
  local file
  local action

  if [[ $# -eq 0 ]]; then
    echo "At least one argument is required."
    return 1;
  fi

  action="$1"
  shift

  case "$action" in
    "list" )
      loader_list
      return $?
      ;;
    "load" )
      loader_loadAll "$@"
      return $?
      ;;
    "show" )
      loader_show "$1"
      return $?
      ;;
    "service" )
      loader_service "$@"
      return $?
      ;;
  esac
}
