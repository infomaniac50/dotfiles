# vim:set filetype=sh:

loader load askyesno
loader load find_in_ancestor
loader load git-redo
loader load git-undo
loader load aliaslast
loader load gi
loader load meta
loader load alias
loader load time
loader load arsync

# Sublimish reveal command
# Mostly used like reveal ./; # This opens the current directory in the file browser
if command_exists exo-open; then
  alias reveal='exo-open'
fi

# bashrc/docker-alias.bashrc

if command_exists docker; then
  # http://www.kartar.net/2014/03/some-useful-docker-bash-functions-and-aliases/
  # Slightly modified
  # I like consistency use dk prefix for everything
  alias dk="docker"
  alias dkip="docker inspect --format '{{ .NetworkSettings.IPAddress }}'"
  alias dkd="docker run -d -P"
  alias dki="docker run -t -i -P"
  dkrm() { docker rm "$(docker ps -a -q --filter "status=exited")"; }
  dkri() { docker rmi "$(docker images -q)"; }
  dkb() { docker build -t="$1" .; }
  # These are mine
  # Remove all untagged images
  function dkrn ()
  {
      for image in $(docker images | tr -s ' ' | cut -f1,3 -d ' ' | grep '<none>' | cut -f2 -d ' ');
      do
          docker rmi $image;
      done
  }

  dksh()
  {
    if [ -z $1 ]; then
      echo "You didn't specify a container."
      return 1
    else
      docker exec -it $1 /bin/bash
    fi
  }

  alias dkps="docker ps"
  alias dkim="docker images"

fi

# bashrc/docker-compose.bashrc
# Because I like fig. It's short and sweet, literally.
if command_exists "docker-compose"; then
  alias fig="docker-compose"
fi

# bashrc/git-annex-alias.bashrc
if command_exists git-annex; then
  alias gan='git-annex'
fi
