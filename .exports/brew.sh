# vim:set filetype=sh:

brew_prefix=$(brew --prefix)

pathprepend $brew_prefix/bin PATH
pathprepend $brew_prefix/share/man MANPATH
pathprepend $brew_prefix/share/info INFOPATH
pathprepend $brew_prefix/share XDG_DATA_DIRS

ssource "$brew_prefix/etc/bash_completion"

unset brew_prefix
