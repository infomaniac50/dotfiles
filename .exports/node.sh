# vim:set filetype=sh:

export NPM_PACKAGES="$HOME/.npm-packages"

# Unset manpath so we can inherit from /etc/manpath via the `manpath` command
# unset MANPATH  # delete if you already modified MANPATH elsewhere in your config
# export MANPATH="$NPM_PACKAGES/share/man:$(manpath)"

export NODE_PATH="$NPM_PACKAGES/lib/node_modules:$NODE_PATH"
export PATH=$NPM_PACKAGES/bin:$PATH
