#!/usr/bin/env bash
# vim:set filetype=sh:

pathprepend ${HOME}/prefix/opt/composer/bin PATH

export COMPOSER_ROOT="$HOME/.composer"
pathprepend $COMPOSER_ROOT/vendor/bin PATH
