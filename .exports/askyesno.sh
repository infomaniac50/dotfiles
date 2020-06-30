# vim:set filetype=sh:

askyesno()
{
    local QUESTION=$1
    local ANSWER

    printf "%s [yes|no] " $QUESTION
    read ANSWER
    if [ $ANSWER = 'yes' -o $ANSWER = 'y' ]; then
        return 0
    else
        return 1
    fi
}
