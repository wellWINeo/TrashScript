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

function help_man(){
	echo "Simple script for realizing Trash functionality"
	echo "written in POSIX shell"
	echo " "
	echo "Homepage: https://github.com/wellWINeo/TrashScript"
	echo "License: MIT (2020)"
	echo " "
	echo "Usage:"
	echo "    del <file>  --  remove file to trash folder"
	echo "    del -n (--now) <file>  -- delete file, without moving it to trash"
	echo "    del --clear ...  -- clear files in trash with time elapsed"
	echo "			       since last access"
	echo "    del --clear-now ...  -- remove all files in trash"
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
			
			"--help")
				help_man
				;;

			"-h")
				help_man
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

