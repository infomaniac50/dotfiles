#!/usr/bin/env bash
# vim:set filetype=sh:

pathprepend ${HOME}/prefix/opt/phpbrew/bin PATH

ssource "$HOME/.phpbrew/bashrc"

function dotfiles-install-php-variants()
{
	if [[ -z $infomaniac50_install_php_version ]]; then
		echo "You must set infomaniac50_install_php_version before running this script."
		return 1
	fi

	phpbrew install --jobs=2 $infomaniac50_install_php_version `cat ${HOME}/prefix/phpbrew-variants.txt`
}

function dotfiles-install-php-extensions()
{
	if [[ -z $infomaniac50_install_php_version ]]; then
		echo "You must set infomaniac50_install_php_version before running this script."
		return 1
	fi

	phpbrew use $infomaniac50_install_php_version

	for ext in $(cat ${HOME}/prefix/phpbrew-extensions.txt); do 
		phpbrew ext install $ext
	done
}

function dotfiles-install-php-xdebug-ini()
{
        if [[ -z $infomaniac50_install_php_version ]]; then
                echo "You must set infomaniac50_install_php_version before running this script."
                return 1
        fi

        phpbrew use $infomaniac50_install_php_version

	installed_ini=$(phpbrew extension show xdebug | grep 'INI File:' | cut -f 2 -d ':')
	cat ${HOME}/prefix/xdebug.ini > $installed_ini
}
