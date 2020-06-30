# vim:set filetype=sh:

ssource /usr/share/nvm/init-nvm.sh

if command_exists yarn; then
  yarn_global_bin=$(yarn global bin)
  pathappend $yarn_global_bin
  unset yarn_global_bin
fi
