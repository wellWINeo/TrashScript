#!/usr/bin/env sh

dir_files=$(ls -A)
trash=/tmp/trash/

function parse_config(){
	sysconfdir="/etc"
	source $sysconfdir/del/config
}


function clear_trash() {
	echo "clearing"
	trash_files=$(ls -A $trash)
	
	for file in $trash_files; do
		let file_lifetime=$(date +%s)-$(stat -c %X $trash/$file)
		
		if [[ $file_lifetime -gt $store_time ]];
		then
			echo $file 
		else
			echo "Not"
		fi
	done
	
}

function clear_trash_all(){
	trash_files=$(ls -A $trash)

	for file in $trash_files; do
		echo $trash_files/$file
		rm -rf $trash/$file
	done
	
}


function main(){
	for ARG in $@; do
		case $ARG in
			"--now")
				echo "--now - ${*: -1}"
				rm -rf ${*: -1}
				break;;
			"-n")
				echo "-n"
				rm -rf ${!#}
				break;;
			"--clear")
				clear_trash;;
			"--clear-all")
				#check=$( clear_trash_all)
				#echo $check
				#if [ $( clear_trash_all) == 1 ]; then
				#	echo "clear_true"
				#else
				#	echo "Trash clear failed!"
				#fi
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

#echo ${*: -1}
main $*

