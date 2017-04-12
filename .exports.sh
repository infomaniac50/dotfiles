# vim:set filetype=sh:

ssource ${HOME}/.exports/eload.sh
ssource ${HOME}/.exports/loader.sh
ssource ${HOME}/.exports/secrets.sh

alias loaderdefault='wf; loader brew prefix fasd cabel golang pypi node composer phpbrew android trash rvm'
alias dload='loaderdefault'
