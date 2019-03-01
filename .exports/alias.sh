#!/usr/bin/env bash
# vim:set filetype=sh:

# bashrc/bash-alias.bashrc

if [ -z $OSTYPE ]; then

if [ "$(uname)" = "Darwin" ]; then
  # Do something under Mac OS X platform
    OSTYPE="darwin";
elif [ "$(expr substr $(uname -s) 1 5)" = "Linux" ]; then
    # Do something under GNU/Linux platform
    OSTYPE="linux-gnu"
elif [ "$(expr substr $(uname -s) 1 10)" = "MINGW32_NT" ]; then
    # Do something under Windows NT platform
    OSTYPE="msys"
fi

fi

bashos=$(echo $OSTYPE | sed s/darwin.*/darwin/)
if [ $bashos != "msys" ]; then
    # Don't alias this on Windows as it causes problems with the native ping.
    alias fastping='ping -c 100 -i .2'
    alias ping='ping -c 5'
fi

# Mac check
if [ $bashos = "darwin" ]; then
    # BSD uses environment variables
    export CLICOLOR=1

    if command_exists gdircolors; then
        # brew install coreutils
        eval $( gdircolors -b $HOME/LS_COLORS/LS_COLORS )
        alias ls='gls --color=auto'
    else
        export LSCOLORS="gxfxcxdxbxegedabagacad"
    fi
else
    eval $( dircolors -b $HOME/LS_COLORS/LS_COLORS )
    alias ls='ls --color=auto'
fi

alias ....='cd ../../../'
alias ...='cd ../../'
alias ..='cd ..'
alias cd..='cd ..'
alias cold='cd $OLDPWD'
alias la='ls -la'
alias ll='ls -l'
alias lh='ls -lh'
alias dush='du -sh *'

alias lsdir='ls -d */'
alias lmount='mount | column -t'
alias ports='netstat -tulanp'
alias zlist='tar --list -zf'
