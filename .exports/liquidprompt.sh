# vim:set filetype=sh:

# This is the lambda character from the Half-Life video game series.
LP_MARK_DEFAULT="$(printf '\u3bb')"

ssource $HOME/liquidprompt/liquidprompt

if [ -r $HOME/.exports/liquidprompt.local.sh ]; then
	ssource $HOME/.exports/liquidprompt.local.sh
fi

# vim:set filetype=sh:
