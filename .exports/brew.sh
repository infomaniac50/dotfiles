# vim:set filetype=sh:

if which brew > /dev/null; then
    brew_prefix=$(brew --prefix)
    export HOMEBREW_FOUND=1
elif [ -e $HOME/.linuxbrew/bin/brew ]; then
    brew_prefix=$($HOME/.linuxbrew/bin/brew --prefix)
    export HOMEBREW_FOUND=1
elif [ -e /usr/local/bin/brew ]; then
    brew_prefix=$(/usr/local/bin/brew --prefix)
    export HOMEBREW_FOUND=1
else
    export HOMEBREW_FOUND=0
fi

if [[ $HOMEBREW_FOUND -eq 1 ]]; then
    pathprepend $brew_prefix/bin PATH
    pathprepend $brew_prefix/share/man MANPATH
    pathprepend $brew_prefix/share/info INFOPATH
    pathprepend $brew_prefix/share XDG_DATA_DIRS

    ssource "$brew_prefix/etc/bash_completion"

    unset brew_prefix
fi
