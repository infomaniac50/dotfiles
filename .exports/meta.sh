# vim:set filetype=sh:

meta()
{
  local implemented="Only aliases, functions, and files are currently implemented."
  local file="$1"
  local shell=$(basename $SHELL)

  if [[ -z "$1" ]]; then
    cat <<EOF
meta [-tf] <alias|function|script>
Prints the definition of any alias, function, or executable shell script.

Example:
meta meta # Prints self. Very Meta!
EOF
    return 1
  fi

  if [[ $shell == "zsh" ]]; then
    case $(type -w "$file" | sed "s/$file\:\ //") in
      alias)
        echo "# Alias $file"
        whence -c "$file"
        ;;
      function)
        echo "# Function $file"
        whence -c "$file"
        ;;
      command)
        file=`whence thing`
        if [[ -L $file ]]; then
          file=`readlink -f "$file"`
        fi
        mime=$(file --brief --mime-type "$file")

        if [[ -f "$file" && $mime == text* ]]; then
          cat "$file"
        else
          echo "Binary File"
          echo $mime
        fi
        ;;
      *)
        echo $implemented
        return 1
        ;;
    esac
  else
      case $(type -t "$file") in
        function)
          echo -n "function "
          type "$file" | tail -n+2
          ;;
        alias)
          alias "$file"
          ;;
        file)
          file=`type -fp "$file"`
          if [[ -L $file ]]; then
            file=`readlink -f "$file"`
          fi
          mime=$(file --brief --mime-type "$file")

          if [[ -f "$file" && $mime == text* ]]; then
            cat "$file"
          else
            echo "Binary File"
            echo $mime
          fi
          ;;
        *)
          echo $implemented
          return 1
          ;;
      esac
  fi
  return 0
}
