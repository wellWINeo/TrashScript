#!/usr/bin/env sh
#
# Simple script for realizing trash functionality
# https://github.com/wellWINeo/TrashScript

dir_files=$(ls -A)

function parse_config(){
	SYSCONFDIR="/etc"
	source $SYSCONFDIR/del/config
}


function clear_trash() {
	trash_files=$(ls -A $trash)
	
	for file in $trash_files; do
		let file_lifetime=$(date +%s)-$(stat -c %X $trash/$file)
		
		if [[ $file_lifetime -gt $store_time ]];
		then
			rm -rf $trash/$file
		fi
	done
	
}

function clear_trash_all(){
	trash_files=$(ls -A $trash)

	for file in $trash_files; do
		rm -rf $trash/$file
	done
	
}


function main(){
	for ARG in $@; do
		case $ARG in
		
			"--now")
				rm -rf ${*: -1}
				break;;
		
			"-n")
				echo "-n"
				rm -rf ${*: -1}
				break;;
		
			"--clear")
				clear_trash;;
			
			"--clear-all")
				clear_trash_all
				echo "Succesfull"
				;;
			*)
				if result=$(mv $ARG $trash 2>&1); then
					echo "Succesfull"	
				else
					echo "Error occured by $ARG"
				fi
				;;
		esac
	done
}

parse_config

main $*

