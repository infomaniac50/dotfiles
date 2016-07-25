# vim:set filetype=sh:

ssource ${HOME}/.exports/eload.sh
ssource ${HOME}/.exports/loader.sh
ssource ${HOME}/.exports/secrets.sh

alias loaderdefault='loader brew rvm cabel golang pypi node composer phpbrew; wf'
alias dload='loaderdefault'
