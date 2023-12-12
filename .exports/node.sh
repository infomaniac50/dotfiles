# vim:set filetype=sh:

# 1. Create a directory for global packages
#    mkdir "${HOME}/.npm-packages"
#
# 2. Tell npm where to store globally installed packages
#    npm config set prefix "${HOME}/.npm-packages"

NPM_PACKAGES="${HOME}/.npm-packages"

pathappend "$NPM_PACKAGES/bin"

# Preserve MANPATH if you already defined it somewhere in your config.
# Otherwise, fall back to `manpath` so we can inherit from `/etc/manpath`.
export MANPATH="${MANPATH-$(manpath)}:$NPM_PACKAGES/share/man"
