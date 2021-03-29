#!/bin/env sh
## CD
########################################################################

## Change Directories
### https://github.com/mathiasbynens/dotfiles
alias cd.="cd . "
alias cd..="cd .. "
alias cd...="cd ../.. "
alias cd....="cd ../../.. "
alias cd.....="cd ../../../.. "

alias ...='../..'
alias ....='../../..'
alias .....='../../../..'
alias ......='../../../../..'

## User Directory Shortcuts
alias down="cd ~/Downloads"
alias desk="cd ~/Desktop"
alias pic="cd ~/Pictures"
alias home="cd ~ "


## brings up the navigation menu
better_cd()
{
	read_key_input()
	{
		local esc=$( printf "\033")

		read -s -n 1 key 2>/dev/null >&2
		if [[ $key = ""     ]]; then echo "enter"; fi;
		if [[ $key = $esc ]]; then
			read -s -n 2 key 2>/dev/null >&2
			if [[ $key = [A ]]; then echo "up"; fi
			if [[ $key = [B ]]; then echo "down"; fi
			if [[ $key = [C ]]; then echo "right"; fi
			if [[ $key = [D ]]; then echo "left"; fi
		fi
	}



	local submenu_sel_index=""
	local submenu_sel_key=""
	print_submenu()
	{


		local dir="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
		if [ "$(type -t getFormatCode)" != 'function' ]; then
			source "$dir/../bash-tools/bash-tools/print_utils.sh"
		fi
		if [ "$(type -t getFormatCode)" != 'function' ]; then
			source "$dir/../bash-tools/bash-tools/color.sh"
		fi


		eraseLines()
		{
			local num_lines=$1
			moveCursorUp $num_lines
			local i=$num_lines
			while [ $i -gt 0 ]; do
				printf "\e[K\n"
				local i=$(($i - 1))
			done
			moveCursorUp $num_lines
		}



		## SETUP
		local options_array=("$@")
		local index=0
		local num_options="$#"
		local last_index=$(($num_options -1))


		## COLOR CONFIGURATION
		local no_color=$(getFormatCode -e reset)
		local text_format=$(getFormatCode -e reverse)


		local loop=true
		while $loop; do

			## PRINT OPTIONS AND HIGHLIGH USER SELECTION
			for i in ${!options_array[@]}; do
				if [[ $index == $i ]]; then
					printf "${text_format}${options_array[$i]}${no_color}\n"
				else
					echo "${options_array[$i]}"
				fi
			done


			## READ USER KEY
			local user_key=$(read_key_input)
			if [ $user_key == "up" ]; then
				if [ $index -gt 0 ]; then
					local index=$((index - 1))

				fi

			elif [ $user_key == "down" ]; then
				if [ $index -lt $last_index ]; then
					local index=$((index + 1))

				fi

			else
				submenu_sel_index="$index"
				submenu_sel_key="$user_key"
				local loop=false

			fi


			## CLEAR OUTPUT
			eraseLines $num_options





		done
	}



	## IF NO ARGUMENTS PASSED -> run better cd version on current folder
	if [ $# -eq 0 ]; then
		# USER SELECTION
		local dir_base="$PWD/"

		while true; do

			## GET CURRENT DIRECTORY TREE
			local dirs=$("ls" -F "${dir_base}" | "grep" \/)

			readarray -t dir_array <<< "$dirs" ## Split array

			for i in ${!dir_array[@]}; do
				dir_array[$i]="${dir_base}${dir_array[$i]}"
			done

			print_submenu "${dir_array[@]}"

			if [ $submenu_sel_key == "enter" ]; then
				"cd" ${dir_array[$submenu_sel_index]}
				break

			elif [ $submenu_sel_key == "right" ]; then
				local dir_base="${dir_array[$submenu_sel_index]}"

			elif [ $submenu_sel_key == "left" ]; then
				local dir_base=$(echo "$dir_base" | sed -n 's/[^\/]*\/[^\/]*$//p')
			fi
		done

	else
		"cd" $@
	fi
}

alias cd='better_cd'

