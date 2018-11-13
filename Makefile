# when you run 'make' alone, run the 'css' rule (at the
# bottom of this makefile)
all: status

# .PHONY is a special command, that allows you not to
# require physical files as the target (allowing us to
# use the 'all' rule as the default target).
.PHONY: all

install:
	cd ../ && stow --ignore='(?:\.git|\.gitattributes|\.git-crypt|\.gitignore|README\.md|install\.sh)' dotfiles/

uninstall:
	cd ../ && stow --ignore='(?:\.git|\.gitattributes|\.git-crypt|\.gitignore|README\.md|install\.sh)' --delete dotfiles/
