#!/bin/bash

# searching functions
find_in_ancestor()
{
  local find_what="$1"
  local starting_directory="$PWD"

  while [ "$PWD" != "/" ] ; do
      if [ -f "$find_what" ]; then
        found_in_ancestor="$PWD/$find_what"
        break
      fi
      cd ..
  done

  # Clean up
  cd $starting_directory

  if [ -z $found_in_ancestor ]; then
    return 1
  else
    return 0
  fi
}
