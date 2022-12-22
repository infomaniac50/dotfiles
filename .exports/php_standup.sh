function php_standup()
{
	local php_version=$1

	if [ -z $php_version ]; then
		echo "You must specify a PHP version string."
		echo "See Also: phpbrew known"
		return 1;
	fi

	phpbrew install --jobs=2 $php_version $(cat ~/prefix/phpbrew-variants.txt)

	if [[ $? && $(read -q "REPLY?The previous command returned an error. Continue? [Y/n]") ]]; then
		return 1;
	fi

	phpbrew switch $php_version

	if [[ $? && $(read -q "REPLY?The previous command returned an error. Continue? [Y/n]") ]]; then
		return 1;
	fi

	phpbrew ext enable opcache

	if [[ $? && $(read -q "REPLY?The previous command returned an error. Continue? [Y/n]") ]]; then
		return 1;
	fi

	local php_extension
	while read php_extension
	do
		if [ ! -z $php_extension ]; then
			phpbrew ext install $php_extension

			if [[ $? && $(read -q "REPLY?The previous command returned an error. Continue? [Y/n]") ]]; then
				return 1;
			fi
		fi
	done < ~/prefix/phpbrew-extensions.txt
}
