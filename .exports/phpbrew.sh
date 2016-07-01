# vim:set filetype=sh:

export PATH=${HOME}/prefix/opt/phpbrew:$PATH

if [ -f $HOME/.phpbrew/bashrc ]; then
  . $HOME/.phpbrew/bashrc
fi
