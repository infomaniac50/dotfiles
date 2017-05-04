#!/bin/bash

command_exists()
{
    hash "$1" 2>/dev/null
    return $?
}

askyesno()
{
    local QUESTION=$1
    local ANSWER

    printf "%s [yes|no] " $QUESTION
    read ANSWER
    if [ $ANSWER = 'yes' -o $ANSWER = 'y' ]; then
        return 0
    else
        return 1
    fi
}

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

git-redo()
{
  if [ -f "${HOME}/.git-undo_msg" ]; then
    git commit -m "$(cat ${HOME}/.git-undo_msg)"
  else
    echo "No undo found"
  fi
}

git-undo()
{
  git log -1 --pretty=%B > "${HOME}/.git-undo_msg"
  echo "Undo commit '$(cat ${HOME}/.git-undo_msg)'"
  echo ""
  git reset HEAD~1
}

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


# Command line interface to gitignore.io
function gi() { curl -L -s "https://www.gitignore.io/api/$*" ;}

meta()
{
  local implemented="Only aliases, functions, and files are currently implemented."
  local file="$1"

  if [[ -z "$1" ]]; then
    cat <<EOF
meta [-tf] <alias|function|script>
Prints the definition of any alias, function, or executable shell script.

Example:
meta meta # Prints self. Very Meta!
EOF
    return 1
  fi

  case $(type -t "$file") in
    function)
      echo -n "function "
      type "$file" | tail -n+2
      ;;
    alias)
      alias "$file"
      ;;
    file)
      file=`type -fp "$file"`
      if [[ -L $file ]]; then
        file=`readlink -f "$file"`
      fi
      mime=$(file --brief --mime-type "$file")

      if [[ -f "$file" && $mime == text* ]]; then
        cat "$file"
      else
        echo "Binary File"
        echo $mime
      fi
      ;;
    *)
      echo $implemented
      return 1
      ;;
  esac

  return 0
}

# bashrc/bash-alias.bashrc

if [ -z $OSTYPE ]; then

if [ "$(uname)" = "Darwin" ]; then
  # Do something under Mac OS X platform
    OSTYPE="darwin";
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    # Do something under GNU/Linux platform
    OSTYPE="linux-gnu"
elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ]; then
    # Do something under Windows NT platform
    OSTYPE="msys"
fi

fi

bashos=$(echo $OSTYPE | sed s/darwin.*/darwin/)
if [ $bashos != "msys" ]; then
    # Don't alias this on Windows as it causes problems with the native ping.
    alias fastping='ping -c 100 -i .2'
    alias ping='ping -c 5'
fi

# Mac check
if [ $bashos = "darwin" ]; then
  # BSD uses environment variables
  export CLICOLOR=1
  export LSCOLORS="gxfxcxdxbxegedabagacad"
else
  # BSD doesn't have the --color arg.
  alias ls='ls --color=auto'
fi

alias ....='cd ../../../'
alias ...='cd ../../'
alias ..='cd ..'
alias cd..='cd ..'
alias cold='cd $OLDPWD'
alias la='ls -la'
alias ll='ls -l'
alias lh='ls -lh'
alias dush='du -sh *'

alias lsdir='ls -d */'
alias lmount='mount | column -t'
alias ports='netstat -tulanp'
alias zlist='tar --list -zf'

# Current 24 hour time
alias now='date +"%T"'
# Current unix timestamp
stamp() { date +"%s"; }

# Archival rsync
arsync() { rsync --recursive --links --perms --devices --specials --times --protect-args --human-readable --partial --progress --itemize-changes --stats "$@"; }

# date and time functions

# rsync functions

# Sublimish reveal command
# Mostly used like reveal ./; # This opens the current directory in the file browser
if command_exists exo-open; then
  alias reveal='exo-open'
fi

# bashrc/docker-alias.bashrc

if command_exists docker; then
  # http://www.kartar.net/2014/03/some-useful-docker-bash-functions-and-aliases/
  # Slightly modified
  # I like consistency use dk prefix for everything
  alias dk="docker"
  alias dkip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
  alias dkd="docker run -d -P"
  alias dki="docker run -t -i -P"
  dkrm() { docker rm $(docker ps -q -a); }
  dkri() { docker rmi $(docker images -q); }
  dkb() { docker build -t="$1" .; }
  # These are mine
  # Remove all untagged images
  function dkrn ()
  {
      for image in $(docker images | grep '<none>' | tr -s ' ' | cut -f3 -d ' ');
      do
          docker rmi $image;
      done
  }

  dksh()
  {
    if [ -z $1 ]; then
      echo "You didn't specify a container."
      return 1
    else
      docker exec -it $1 /bin/bash
    fi
  }

  alias dkps="docker ps"
  alias dkim="docker images"

fi

# bashrc/docker-compose.bashrc
# Because I like fig. It's short and sweet, literally.
if command_exists "docker-compose"; then
  alias fig="docker-compose"
fi

# bashrc/git-annex-alias.bashrc
if command_exists git-annex; then
  alias gan='git-annex'
fi
