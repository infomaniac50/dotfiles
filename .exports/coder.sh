#!/usr/bin/env bash


coder()
{
  settings_file=".coder"

  action="$1"
  shift

  case $action in
    "example" )
        cat <<EOF
#!/bin/bash

# Keep the trailing slashes consistent
# if you want rsync to upload to the right place.

# Extra rsync arguments
# if find_in_ancestor "rsync-exclude.txt"; then
  # export extra_=--exclude-from="$found_in_ancestor"

  # Local Project Directory
  export local_='src/'

  # Remote Project Directory
  export remote_='<username>@<host>:public_html/'
# fi
EOF
      exit 0
      ;;
    "help" )
      echo "Usage: ${0##*/} [push|pull] <extra rsync arguments>"
      exit 0
      ;;
    "usage" )
      echo "Usage: ${0##*/} [push|pull] <extra rsync arguments>"
      exit 0
      ;;
  esac

  # if .coder does not exist in the current directory
  if [ ! -f ".coder" ]; then
    if find_in_ancestor $settings_file; then
      # Found .coder in one of the parent directories.
      settings_file="$found_in_ancestor"
      unset found_in_ancestor
    else
      echo_fail ".coder does not exist in this directory or any of it's parents!"
      exit 1
    fi
  else
    settings_file="${PWD}/${settings_file}"
  fi

  . "${settings_file}"
  local_="$(dirname $settings_file)/${local_}"

  if [ -z $extra_ ]; then
    extra_=""
  fi

  case $action in
    "pull" )
      arsync "$remote_" "$local_" $extra_ "$@"
      ;;
    "push" )
      arsync "$local_" "$remote_" $extra_ "$@"
      ;;
    "fix_perms" )
      find "$local_" -type d -not -wholename "$local_" -exec chmod 755 '{}' \;
      find "$local_" -type f -exec chmod 644 '{}' \;
      ;;
    "status" )
      arsync "$local_" "$remote_" $extra_ -n "$@"
      ;;
    * )
      echo "Usage: ${0##*/} [push|pull] <extra rsync arguments>"
      ;;
  esac

}
