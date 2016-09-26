## Dotfiles

A place to store my configs I have painstakingly built up over the years.

Some of these files contain sensitive data. Therefore I have encrypted these files with [git-crypt](https://github.com/AGWA/git-crypt).

Some of the shell init files are forked from Peter Ward's [Shell Startup](https://bitbucket.org/flowblok/shell-startup). Read more about it [here](http://blog.flowblok.id.au/2013-02/shell-startup-scripts.html)

### Installing - install.sh

You should run this from the parent directory of this git repository.

```bash
bash dotfiles/install.sh
```

Also, in order for GNU Stow to work, you need to clone dotfiles into a directory one level deep from your home directory.

```
cd ~
mkdir workspace
cd workspace/
git clone https://github.com/infomaniac50/dotfiles
```
