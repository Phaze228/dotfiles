
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

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar


## TERMINAL COLOR AND PS1 PROMPT ##
# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac


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


# JQ COLORS #
#    1 ; 2    ; 3  ; 4    ;   5   ;  6   ;   7   ;  8   
#  null;false;true;numbers;strings;arrays;objects;object-keys
export JQ_COLORS="0;90:0;39:0;39:0;39:0;34:1;39:1;39:1;34"

# -- Source GIT prompt -- #
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
if [ "$color_prompt" = yes ]; then
    export PS1="\[$BOLD$UC\]\u\[$R\]@\[$BOLD$HC\]\h\[$R\]|\[$DC\]\w\[$R\]:\[$GC\]$(__git_ps1 '%s')\[$R\]$ "
    export PS2=">> "
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:[\w]$ '
fi
# INITIAL_PROMPT="\[$BOLD$UC\]\u\[$R\]@\[$BOLD$HC\]\h\[$R\]|\[$DC\]\w\[$R\]:\[$GC\]$(__git_ps1 '%s')\[$R\]$ "
unset color_prompt force_color_prompt
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
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'
#
#
# make less more friendly for non-text input files, see lesspipe(1) 
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# Enable colors in LESS
lesscolors=$HOME/.config/.LESS_TERMCAP
[[ -f $lesscolors ]] && . $lesscolors

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

export ANDROID_HOME=/opt/mobile_app_dev/android

PATHS_TO_ADD=(
    "~/.local/bin"
    "~/.cargo/bin"
    "~/go/bin"
    "~/.local/flutter/"
    "/home/phaze/.rustup/toolchains/stable-x86_64-unknown-linux-gnu/bin/"
    "/usr/local/go/bin"
    "/usr/share/pywhisker"
    "/usr/share/EyeWitness/Python/"
    "/usr/share/zen"
    "/opt/mobile_app_dev/flutter/bin"
    "/opt/mobile_app_dev/android/cmdline-tools/bin"
    "/opt/mobile_app_dev/android/emulator/"
    "/opt/mobile_app_dev/android/platform-tools"
)



export PATH=$PATH:$(echo ${PATHS_TO_ADD[*]} | tr ' ' ':')
export MANPAGER='less -s -M +Gg'
export LESS="--RAW-CONTROL-CHARS"

## Google Cloud CLI
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/opt/google-cloud-sdk/path.bash.inc' ]; then . '/opt/google-cloud-sdk/path.bash.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/opt/google-cloud-sdk/completion.bash.inc' ]; then . '/opt/google-cloud-sdk/completion.bash.inc'; fi

## Source other config files ##
if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

if [ -f ~/.bash_github ]; then
    . ~/.bash_github
fi


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


# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac




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
    convert ${bg} ${lockimg}
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
    [[ "$name" =~ "buds" ]] && bluetoothctl connect AC:3E:B1:84:35:BB  ## ear_buds
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

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
