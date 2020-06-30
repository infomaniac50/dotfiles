# vim:set filetype=sh:

git-undo()
{
  git log -1 --pretty=%B > "${HOME}/.git-undo_msg"
  echo "Undo commit '$(cat ${HOME}/.git-undo_msg)'"
  echo ""
  git reset HEAD~1
}
