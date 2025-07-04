
# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

## HISTORY SETTINGS ###
# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
HISTTIMEFORMAT="[ %Y/%m/%d %T ] "

### SHOPT SETTINGS ####
# append to the history file, don't overwrite it
shopt -s histappend
# check the window size after each command and, if necessary, update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar




### JQ COLORS ###
#    1 ; 2    ; 3  ; 4    ;   5   ;  6   ;   7   ;  8   
#  null;false;true;numbers;strings;arrays;objects;object-keys
export JQ_COLORS="0;90:0;39:0;39:0;39:0;34:1;39:1;39:1;34"


### Terminal Prompts ###
## -- Source GIT prompt -- ##
source ~/.scripts/git-prompt.sh
# --  COLORS -- #
# R='\e[0m'
# LIGHT_BLUE='\e[01;38;2;67;149;206m'
# DARK_BLUE='\e[01;38;2;3;101;140m'
# DARK_PURPLE='\e[01;38;2;56;36;94m'
# RED='\e[01;38;2;200;10;10m'
# CYAN='\e[01;38;2;0;200;200m'
#
#
## TPUT COLORS ##
R=$(tput sgr0)            # Reset
BOLD=$(tput bold)
LIGHT_BLUE=$(tput setaf 44)  # Approximate light blue
DARK_BLUE=$(tput setaf 31)    # Approximate dark blue
DARK_PURPLE=$(tput setaf 93)   # Approximate dark purple
LIGHT_PURPLE=$(tput setaf 127)   # Approximate dark purple
CYAN=$(tput setaf 51)        # Approximate cyan
RED=$(tput setaf 1)         # Red
GREEN=$(tput setaf 10)


## Prompt Colors ##
UC=$LIGHT_PURPLE  #User \u Color
HC=$DARK_BLUE     #Host \h Color
DC=$GREEN         #Dir \w Color
GC=$RED           #GIT    Color
GITP=$(__git_ps1 " (%s)")

export PS1="\[$BOLD$UC\]\u\[$R\]@\[$BOLD$HC\]\h\[$R\]|\[$DC\]\w\[$R\]:\[$GC\]$(__git_ps1 '%s')\[$R\]$ "
export PS2=">> "

# INITIAL_PROMPT="\[$BOLD$UC\]\u\[$R\]@\[$BOLD$HC\]\h\[$R\]|\[$DC\]\w\[$R\]:\[$GC\]$(__git_ps1 '%s')\[$R\]$ "

PROMPT_COMMAND='
    cur_dir="$PWD"
    if [[ "$cur_dir" != "$prev_dir" ]]; then
	PS1="\[$BOLD$UC\]\u\[$R\]@\[$BOLD$HC\]\h\[$R\]|\[$DC\]\w\[$R\]:\[$GC\]$(__git_ps1 '%s')\[$R\]$ "
    else
	PS1=${PS1/w/W}
    fi 
    prev_dir="$PWD"
'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
#
#
## Less Configuration ##

# make less more friendly for non-text input files, see lesspipe(1) 
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Pretty colors for the `less` utility
lesscolors=$HOME/.config/.LESS_TERMCAP

[[ -f $lesscolors ]] && . $lesscolors
unset lesscolors

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'


### Path Configuration ###
PATHS_TO_ADD=(
    "~/.local/bin"
    "~/.cargo/bin"
    "~/go/bin"
    "~/.local/share/gem/ruby/3.3.0/bin"
    "~/.local/share/gem/ruby/3.4.0/bin"
    # "~/.local/share/uv/python/cpython-3.13.3-linux-x86_64-gnu/bin/"
    # "~/.local/flutter/"
    # "/home/phaze/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/"
    "/usr/local/go/bin"
    # "/usr/share/pywhisker"
    # "/usr/share/EyeWitness/Python/"
    # "/usr/share/zen"
    "/opt/john/run/"
    # "/opt/mobile_app_dev/flutter/bin"
    # "/opt/mobile_app_dev/android/cmdline-tools/bin"
    # "/opt/mobile_app_dev/android/emulator/"
    # "/opt/mobile_app_dev/android/platform-tools"
)



export PATH=$PATH:$(echo ${PATHS_TO_ADD[*]} | tr ' ' ':')
# export ANDROID_HOME=/opt/mobile_app_dev/android
# bun
# export BUN_INSTALL="$HOME/.bun"
# export PATH="$BUN_INSTALL/bin:$PATH"

## Google Cloud CLI ##
# The next line updates PATH for the Google Cloud CLI and completion for CLI arguments
[ -f '/opt/google-cloud-cli/path.bash.inc' ] && . /opt/google-cloud-cli/path.bash.inc
[ -f '/opt/google-cloud-cli/completion.bash.inc' ] && . /opt/google-cloud-cli/completion.bash.inc

## AWS CLI ##
[ -f '/usr/bin/aws_completer' ] && complete -C '/usr/bin/aws_completer' aws


export MANPAGER='less -s -M +Gg'
export LESS="--RAW-CONTROL-CHARS"






### Functions ####
function remove_old_snaps() {
    sudo /home/phaze/.scripts/remove_old_snaps.sh
}

function refreshbg() {
    . ~/.config/i3/.fehbg
}

function setbg() {
    [ -z $1 ] && echo "setbg <jpg file>" && return 1
    local bg=$(realpath "${1}")
    local lockimg=${bg/jpg/png}
    magick ${bg} ${lockimg}
    ln -sf ${bg} ~/.config/i3/background.jpg
    ln -sf ${lockimg} ~/.config/i3/lock.png
    refreshbg
}


function nv_run() {
    export DRI_PRIME=1
    export __GLX_VENDOR_LIBRARY_NAME=nvidia
    export __NV_PRIME_RENDER_OFFLOAD=1
    export __VK_LAYER_NV_optimus=NVIDIA_only
    [ ! -z $1 ] && . $1
}

function print_colors() {
    declare reset=$(tput sgr0)
    for ((i=0; i < 256; i++)) {
	if (( $i % 8 == 0)) && [[ $i -gt 0 ]] then
	    printf "\n"
	fi
	declare color=$(tput setaf $i)
	printf "$color %03d $reset" $i
    }
    printf "\n"
}

function btc() {
    local name="{$1-}"
    # [[ "$name" =~ "buds" ]] && bluetoothctl connect AC:3E:B1:84:35:BB  ## ear_buds
    [[ "$name" =~ "buds" ]] && bluetoothctl connect 14:22:3B:D9:B8:DF ## old/new buds
    [[ "$name" =~ "bose" ]] && bluetoothctl connect 2C:41:A1:2C:6A:B1 ## bose_soundlink

}


# #HacktheBox
# function htba() {
#     openvpn ~/.hackthebox/academy-regular.ovpn
# }
#
# function htbl() {
#     openvpn ~/.hackthebox/lab-regular.ovpn
# }

## FZF Bindings ##
[ -f /usr/share/fzf/completion.bash ] && . /usr/share/fzf/completion.bash
[ -f /usr/share/fzf/key-bindings.bash ] && .  /usr/share/fzf/key-bindings.bash

## Source local configs ##

[ -f ~/.bash_aliases ] && . ~/.bash_aliases
[ -f ~/.bash_github ] && . ~/.bash_github
