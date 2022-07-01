#!/bin/bash

allPHPVersions=("php8.1" "php8.0" "php7.4" "php7.3" "php7.2" "php7.1" "php7.0" "php5.6")

existsPHPVersions=()

for value in "${allPHPVersions[@]}"
do
	  if command -v $value &> /dev/null
	  then
		  existsPHPVersions+=("")
		  existsPHPVersions+=("$value")
	  fi
done

currentPHPVersion=$(php -v)

select=$(zenity --list --title="Choose PHP Version" --radiolist --height="350" --text="Current PHP Version is $currentPHPVersion" \
	  --column="" --column="Version" "${existsPHPVersions[@]}")

if [[ "$?" != "0" ]] ; then
				exit 1
		  fi

command sudo update-alternatives --set php /usr/bin/$select > /dev/null

zenity --info \
		 --title "Current PHP Version" \
		 --width 200 \
		 --height 100 \
		 --text "Your PHP version is $select"
