# vim:set filetype=sh:

pathprepend $HOME/.linuxbrew/bin PATH
pathprepend $HOME/.linuxbrew/share/man MANPATH
pathprepend $HOME/.linuxbrew/share/info INFOPATH
pathprepend $HOME/.linuxbrew/share XDG_DATA_DIRS

pathprepend $HOME/prefix/sbin:$HOME/prefix/bin:$HOME/prefix/usr/local/bin PATH

brew_prefix=$(brew --prefix)

ssource "$brew_prefix/etc/bash_completion"

if which fasd > /dev/null; then eval "$(fasd --init auto)"; fi

unset brew_prefix
