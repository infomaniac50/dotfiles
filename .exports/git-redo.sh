# vim:set filetype=sh:

git-redo()
{
  if [ -f "${HOME}/.git-undo_msg" ]; then
    git commit -m "$(cat ${HOME}/.git-undo_msg)"
  else
    echo "No undo found"
  fi
}
