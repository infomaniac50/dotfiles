# vim:set filetype=sh:

export PATH=$HOME/prefix/sbin:$HOME/prefix/bin:$HOME/prefix/usr/local/bin:$PATH

brew_prefix=$(brew --prefix)

if [ -f "$brew_prefix/etc/bash_completion" ]; then
    . "$brew_prefix/etc/bash_completion"
fi

unset brew_prefix
