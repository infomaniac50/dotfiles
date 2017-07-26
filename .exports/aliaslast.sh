#!/bin/bash

aliaslast()
{
  if [ -z "$1" ]; then
    cat <<EOF
aliaslast [aliasname]
Add the most recent command as an alias
EOF
    return 1;
  fi

  # SC2139 I have verified the functionality of this code.
  # shellcheck disable=SC2139
  alias $1="`history 2 | head -n1 | sed 's/ *[0-9]* *//'`"
}
