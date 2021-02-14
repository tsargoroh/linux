#!/bin/bash

#chmod u+o battery.sh -> add execution permission to all users
# xargs -> convert input from stdin into arguments to a command
# grep -e aaa -e bbb -> search for aaa and bbb patterns
# sed "s/^[ ]*//" -> from the beginning of line substitute all " " with ""
temp=$(upower -e | grep "BAT" | xargs upower -i | grep -e state -e percentage | sed "s/^[ ]*//") 	#redirecting command output to variable temp
#IFS=$'\n'																							#Internal Field Separator is a special shell variable (default value is space, tab, newline)
array=($temp)																						#to get the output of a command in an array, with one line per element, use IFS (ok) or mapfile (better)
#echo "${#array[@]}"

echo -e "\e[1;36m### BATTERY STATUS ###\e[0m"											#echo -e "xxx" -> allow backslash escapes
																						#"\e" start the escape character in bash, "[36m" cyan, "[1;36m" bold cyan, "[0m" no colour
if [ ${array[1]} == "fully-charged" -o ${array[1]} == "charging" ]; then
	echo -e "${array[0]}\t\t\e[1;32m${array[1]}\e[0m"
elif [ ${array[1]} == "discharging" ]; then
	echo -e "${array[0]}\t\t\e[1;31m${array[1]}\e[0m"
fi
percentage=$(sed "s/\([0-9]*\).*/\1/" <<< ${array[3]})							#using sed to manipulate ${array[3]} -> substitute the entire line with percentage int (for example 92% -> 92)
																				#subexpression inside "\(" opening and "\)" closing parenthesis, "\1" represents the text that matches the first subexpression
																				#bash also supports this sort of replacement natively
																				#${parameter/pattern/string} -> replace the first match of pattern with string
																				#${parameter//pattern/string} -> replace all matches of pattern with string
if [ $percentage -ge 80 ]; then
	echo -e "${array[2]}\t\e[1;32m${array[3]}\e[0m"							#"[1;32m" bold green
elif [ $percentage -lt 80 -a $percentage -ge 40 ]; then
	echo -e "${array[2]}\t\e[1;33m${array[3]}\e[0m"							#"[1;33m" bold yellow
else
	echo -e "${array[2]}\t\e[1;31m${array[3]}\e[0m"							#"[1;31m" bold red
fi
