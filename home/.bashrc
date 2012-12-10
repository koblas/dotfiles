# /etc/skel/.bashrc
#
# This file is sourced by all *interactive* bash shells on startup,
# including some apparently interactive shells such as scp and rcp
# that can't tolerate any output.  So make sure this doesn't display
# anything or bad things will happen !


# Test for an interactive shell.  There is no need to set anything
# past this point for scp and rcp, and it's important to refrain from
# outputting anything in those cases.
if [[ $- != *i* ]] ; then
	# Shell is non-interactive.  Be done now!
	return
fi

### Begin from AWS

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

### End from AWS

# Enable colors for ls, etc.  Prefer ~/.dir_colors #64489
if [[ -f ~/.dir_colors ]] ; then
	eval $(dircolors -b ~/.dir_colors)
elif [[ -f /etc/DIR_COLORS ]] ; then
	eval $(dircolors -b /etc/DIR_COLORS)
fi

#BSD#@export CLICOLOR=1
#GNU#@alias ls='ls --color=auto'
#alias grep='grep --colour=auto'

# Change the window title of X terminals 
PROMPT_COLOR=""
case ${TERM} in
	xterm*|rxvt*|Eterm|aterm|kterm|gnome)
		PROMPT_COMMAND='echo -ne "\e]0;${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\007"'
        PROMPT_COLOR="\e[37m"
		;;
	vt100)
        TITLEBAR='\[\033]0;\h:\w\007\]'
		;;
	screen)
		PROMPT_COMMAND='echo -ne "\e_${USER}@${HOSTNAME%%.*}:${PWD/$HOME/~}\e\\"'
		;;
esac

set -o ignoreeof 

export VISUAL=vi

#alias winky="mysql --user=scott --password=tiger --host=127.1 winky"
#alias swiki="mysql --user=root --password=raphe0n --host=127.1 --port=3366 swikidb"
alias cd='oldcwd="$PWD" ; cd $* '
alias back='olddst="$oldcwd" ; cd $olddst'

if [[ $USER != 'koblas' ]] ; then
    PS1="${PROMPT_COLOR}${TITLEBAR}[\u@\h:\w] $ "
else
    PS1="${PROMPT_COLOR}${TITLEBAR}[\h:\w] $ "
fi

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
