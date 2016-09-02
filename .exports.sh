# vim:set filetype=sh:

ssource ${HOME}/.exports/eload.sh
ssource ${HOME}/.exports/loader.sh
ssource ${HOME}/.exports/secrets.sh

alias loaderdefault='loader brew cabel golang pypi node composer phpbrew android trash rvm; wf'
alias dload='loaderdefault'
