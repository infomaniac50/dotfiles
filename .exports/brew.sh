# vim:set filetype=sh:

pathprepend $HOME/prefix/sbin:$HOME/prefix/bin:$HOME/prefix/usr/local/bin PATH

brew_prefix=$(brew --prefix)

ssource "$brew_prefix/etc/bash_completion"

if which fasd > /dev/null; then eval "$(fasd --init auto)"; fi

unset brew_prefix
