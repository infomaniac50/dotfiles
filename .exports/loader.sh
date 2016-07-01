# vim:set filetype=sh:

function loader
{
  if [[ $# -eq 0 ]]; then
    echo "At least one loader script argument is required."
    return 1;
  fi

  local file

  case "$1" in
    "--list" )
      for file in ${HOME}/.exports/*.sh; do
        basename ${file%%.sh}
      done
      return 0
      ;;
  esac

  for file in "$@"; do
    eload $file
  done
}
