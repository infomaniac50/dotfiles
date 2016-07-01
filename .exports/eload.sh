# vim:set filetype=sh:

function eload
{
  if [[ -z $1 ]]; then
    return 1;
  fi

  local file="${HOME}/.exports/$1.sh"

  if [[ -e $file ]]; then
    . $file
  fi
}
