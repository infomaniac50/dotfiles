# vim:set filetype=sh:

function gopath_defaults() {
  #GOROOT=$HOME/prefix/opt/go
  if [ ! -z $GOPATH ] && [ -d $GOPATH/bin ]; then
    pathremove $GOPATH/bin PATH
  fi
  export GOPATH=$HOME/workspace/go
  pathprepend $GOPATH/bin PATH
}

# Derived from https://hgfischer.org/article/managing-multiple-gopaths/
function gopath() {
  local cdir=$PWD
  local found=0

  # Look for .gopath in current and parent directories.
  # If found then set GOPATH.
  while [ "$cdir" != "/" ]; do
    if [ -e "$cdir/.gopath" ]; then
      if [ ! -z $GOPATH ] && [ -d $GOPATH/bin ]; then
        pathremove $GOPATH/bin PATH
      fi
      export GOPATH=$cdir
      pathprepend $GOPATH/bin PATH
      found=1
      break
    fi
    cdir=$(dirname "$cdir")
  done

  # If not found then set GOPATH defaults.
  if [[ $found -eq 0 ]]; then
    gopath_defaults
  fi
}

gopath_defaults
