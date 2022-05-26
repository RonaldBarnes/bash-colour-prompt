function define_colours {
	echo "define_colours()..."
	## Remember: Foreground colour FIRST, then optional BACKGROUND colour:
	# ANSI color escape sequences
	## Per Arch wiki: High intensity range is 90-97
	## All 8 colours, their bold / light versions, plus 8 background colours:
	black='\e[0;30m'
	gray="\e[1;30m"
	black_background="\e[40m"
	red='\e[0;31m'
	pink='\e[1;31m'				## red bold & slightly different hue
	red_background="\e[41m"
	green='\e[0;32m'
	green_light="\e[1;32m"
	green_background="\e[42m"
	yellow='\e[1;33m'
	orange='\e[33m'			## aka brown-ish
	yellow_background="\e[43m"
	orange_background="${yellow_background}"
	blue='\e[0;34m'
	blue_light="\e[1;34m"	## actually just blue bold
	blue_background="\e[44m"
	magenta="\e[0;35m"
	purple="\e[1;35m"			## actually just magenta bold
	purple_background="\e[45m"
	cyan="\e[0;36m"
	cyan_bold="\e[1;36m"
	cyan_background="\e[46m"
	white='\e[0;37m'
	white_bold="\e[1;37m"
	white_background="\e[47m"
	default_color="\e[00m"
	}
define_colours





## Determine which, if any, git branch is currently active:
function git_branch {
	## Run git branch, discarding errors, capturing branches if in repo:
	## Delete lines NOT starting with asterisk:
	## Remove asterisk & space from start of line, insert "(git:...)":
	gb=$(git status 2>/dev/null | head -n 1 | awk '{print $3}')

	if [[ ${#gb} -ne 0  ]]; then
		echo -n "(git:${gb})"
	fi
	unset gb
	}






# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
	if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
		# We have color support; assume it's compliant with Ecma-48
		# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
		# a case would tend to support setf rather than setaf.)
		color_prompt=yes
	else
		color_prompt=
	fi
fi



if [ "$color_prompt" = yes ]; then
	## NOTE: ACTUAL COLOURS DEPEND UPON TERMINAL / KONSOLE SETTINGS
	## NOTE: ACTUAL COLOURS DEPEND UPON TERMINAL / KONSOLE SETTINGS
	## NOTE: ACTUAL COLOURS DEPEND UPON TERMINAL / KONSOLE SETTINGS
	## i.e. "zotac" konsole style / profile makes PWD disappear
	## i.e. "root"  konsole style / profile makes PWD disappear
	##
	## Setting black backgrounds for a consistent look did not help with above.
	##
	##
	## echo "Colourizing prompt... ${color_prompt}"
	##
	## NOTE: for using ${colour_name}, prepend \[ for "non-printing char" else
	## line-wrapping breaks, per
	## https://www.gilesorr.com/blog/bash-prompt-01-colours.html
	##
	## Ubuntu / Debian default:
	PS1='${debian_chroot:+($debian_chroot)}'
	##
	## Now for USER:
	PS1=${PS1}"\[${black_background}${orange}\]\u"
	## "@" part of USER@HOST:
	## Weird: with white, the background needs to be set AFTER white:
	PS1=${PS1}"\[${white}${black_background}\]@"
	## HOST:
	PS1=${PS1}"\[${black_background}${blue_light}\]\h"
	## present WORKING directory:
	PS1=${PS1}" \[${blue}${black_background}\][\w]"
	## NEW-line:
	## WEIRD: single quotes completely breaks next line?:
	## NO: double quotes required on ${colour} for interpolation / substitution
	PS1=${PS1}"\n"
	## Second line prompt:
	##	PS1=${PS1}" ░\030▒▓ └─» "
	PS1=${PS1}"\[${black_background}${orange}\] └─» "
	## git branch info (NOTE: cannot be empty branch, at least one commit req'd:
	PS1=${PS1}"\[${red}${black_background}\]\$(git_branch)"
	## Built-in git stuff, not sure how to use:
	## PS1=${PS1}'$(__git_ps1_colorize_gitstring)'
	## $ for normal user, # for root (don't forget to escape the \$ via \\$!):
	PS1=${PS1}"\[${white}${black_background}\]\\$"
	##
	## Place time in top-right corner of screen:
	## Escape the $(tput) thusly \$(tput) so it executes EVERY prompt draw:
	PS1=${PS1}"\[${black_background}${default_color}\$(tput sgr0)\] "
	PS1=${PS1}"\[\$(tput sc; tput cup 0 \$(( \${COLUMNS} - 8)) ; )\]"
	PS1=${PS1}"\[${white}${purple_background}\t${default_color}\$(tput rc)\]"
	## AND, reset to "normal" colour, and background_black to get rid of
	## lingering purple colour to right edge of screen:
	## PS1=${PS1}"\[${black_background}${default_color}\]"
	PS1=${PS1}"\[${black_background}${default_color}\$(tput sgr0)\]"
else
	echo "Colourizing prompt... NO ${color_prompt}"
	PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt
