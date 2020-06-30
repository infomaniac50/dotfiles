# vim:set filetype=sh:

command_exists()
{
    hash "$1" 2>/dev/null
    return $?
}

loader_dependsAll()
{
  local script
  local exportName=$(echo "LOADER_DEPENDS_${script}" | sed -e 's/[a-z]/\U&/g')
  exportName=$(echo "$exportName" | sed -e 's/[- ]/_/g')
	
  for script in "$@"; do
    if [[ $$exportName -ne 1 ]]; then
      loader_load "$script"
    fi
  done

  return $?
}

loader_load()
{
  file="${HOME}/.exports/$1.sh"
  local exportName=$(echo "LOADER_DEPENDS_${script}" | sed -e 's/[a-z]/\U&/g')
  exportName=$(echo "$exportName" | sed -e 's/[- ]/_/g')

  if [[ -e "$file" ]]; then
    export $exportName=1
    . "$file"
  fi

  return $?
}

loader_loadAll()
{
  local script

  for script in "$@"; do
    loader_load "$script"
  done

  return $?
}

loader_show()
{
  local script="$1"
  local file="${HOME}/.exports/$script.sh"

  if [[ -e "$file" ]]; then
    cat "$file"
  fi

  return $?
}

loader_list()
{
  local scripts="${HOME}/.exports/*.sh"
  local script

  for script in $scripts; do
    basename ${script%%.sh}
  done

  return $?
}

loader_service()
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

loader()
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

alias lol="loader load"
alias los="loader service"
