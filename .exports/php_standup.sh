function php_standup()
{
	local php_version=$1

	if [ -z $php_version ]; then
		echo "You must specify a PHP version string."
		echo "See Also: phpbrew known"
		return 1;
	fi

	if [[ $(read -qs "REPLY?Should OpenSSL v1 be used instead of v3? [Y/n]") ]]; then
		export LDFLAGS=-L/usr/lib/openssl-1.1/
		export CPPFLAGS=-I/usr/include/openssl-1.1/
	fi
	echo ""

	phpbrew install --jobs=2 $php_version $(cat ~/prefix/phpbrew-variants.txt)

	if [[ $? && $(read -qs "REPLY?The previous command returned an error. Continue? [Y/n]") ]]; then
		return 1;
	fi
	echo ""

	phpbrew switch $php_version

	if [[ $? && $(read -qs "REPLY?The previous command returned an error. Continue? [Y/n]") ]]; then
		return 1;
	fi
	echo ""

	phpbrew ext enable opcache

	if [[ $? && $(read -qs "REPLY?The previous command returned an error. Continue? [Y/n]") ]]; then
		return 1;
	fi
	echo ""

	local php_extension
	while read php_extension
	do
		if [ ! -z $php_extension ]; then
			phpbrew ext install $php_extension

			if [[ $? && $(read -qs "REPLY?The previous command returned an error. Continue? [Y/n]") ]]; then
				return 1;
			fi
			echo ""
		fi
	done < ~/prefix/phpbrew-extensions.txt

	echo "Updating config files"
	local PHP_CLI_INI="$(phpbrew path etc)/cli/php.ini"
	echo "Trying $PHP_CLI_INI"
	if [[ -e $PHP_CLI_INI ]]; then
		echo -n "Old Settings: "
		grep 'memory_limit' "$PHP_CLI_INI"
		sed --in-place --regexp-extended --expression='s/memory_limit = [0-9]+[MG]/memory_limit = 4096M/' $PHP_CLI_INI
		local sed_return=$?
		echo -n "New Settings: "
		grep 'memory_limit' "$PHP_CLI_INI"
	else
		echo "The php-cli INI file not accessible."
	fi

	local PHP_FPM_INI="$(phpbrew path etc)/fpm/php.ini"
	echo "Trying $PHP_FPM_INI"
	if [[ -e $PHP_FPM_INI ]]; then
		echo -n "Old Settings: "
		grep 'memory_limit' "$PHP_FPM_INI"
		sed --in-place --regexp-extended --expression='s/memory_limit = [0-9]+[MG]/memory_limit = 4096M/' $PHP_FPM_INI
		local sed_return=$?
		echo -n "New Settings: "
		grep 'memory_limit' "$PHP_FPM_INI"
	else
		echo "The php-fpm INI file not accessible."
	fi

	local DOTFILES_PREFIX_XDEBUG_INI="$HOME/prefix/xdebug.ini"
	local PHP_GLOBAL_XDEBUG_INI="$(phpbrew path config-scan)/xdebug.ini"
	echo -n "Trying $PHP_GLOBAL_XDEBUG_INI "
	if [[ -e $PHP_GLOBAL_XDEBUG_INI ]]; then
		cat $DOTFILES_PREFIX_XDEBUG_INI > $PHP_GLOBAL_XDEBUG_INI
		echo "Done"
	else
		echo "Not Found"
	fi

	local PHP_CLI_XDEBUG_INI="$(phpbrew path config-scan)/cli/xdebug.ini"
	echo -n "Trying $PHP_CLI_XDEBUG_INI "
	if [[ -e $PHP_CLI_XDEBUG_INI ]]; then
		cat $DOTFILES_PREFIX_XDEBUG_INI > $PHP_CLI_XDEBUG_INI
		echo "Done"
	else
		echo "Not Found"
	fi

	local PHP_FPM_XDEBUG_INI="$(phpbrew path config-scan)/fpm/xdebug.ini"
	echo -n "Trying $PHP_FPM_XDEBUG_INI "
	if [[ -e $PHP_FPM_XDEBUG_INI ]]; then
		cat $DOTFILES_PREFIX_XDEBUG_INI > $PHP_FPM_XDEBUG_INI
		echo "Done"
	else
		echo "Not Found"
	fi
}
