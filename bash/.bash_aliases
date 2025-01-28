

# some more ls aliases
alias ls='exa'
alias li="exa --icons"
alias ll='exa -alF'
alias la='exa -A'
alias l='exa -CF'


alias py="python3"
alias vim="nvim"
alias ipy="ipython3"
alias pgf="cd ~/Programming"
alias tcopy="xclip -sel clip -i"
alias tpaste="xclip -sel clip -o"
alias bat="batcat"

# Time #
alias utc="date -u '+%Y-%m-%d %H:%M:%S'"
alias dtpdate="date +%Y-%m-%d\ %H:%M:%S.%N"

# Configs #
alias vimcfg="nvim ~/.config/nvim/init.lua"
alias i3cfg="nvim ~/.config/i3/config"
alias bashcfg="nvim ~/.bashrc && source ~/.bashrc"
alias tmuxcfg="nvim ~/.tmux.conf"
alias aliascfg="nvim ~/.bash_aliases && source ~/.bash_aliases"
alias ghostcfg="nvim ~/.config/ghostty/config"

#Weather
alias weather="curl wttr.in"


# Notes #
alias hnotes="cd ~/Documents/knowledge_vault/Hacking/"
alias tdcd="cd ~/Documents/knowledge_vault/tldr_notes/"

# #HacktheBox
alias htb="cd ~/Programming/HackTheBox/"
alias htba="sudo openvpn ~/.hackthebox/academy.ovpn; ~/.bashrc"
alias htbs="sudo openvpn ~/.hackthebox/seasonal.ovpn; . ~/.bashrc"
alias htbl="sudo openvpn ~/.hackthebox/lab.ovpn; . ~/.bashrc"
alias copyflags="cat user.flag | tcopy; sleep 3; cat root.flag| tcopy"

# Hack Tools #
alias john="/opt/john/run/john"
alias zip2john="/opt/john/run/zip2john"
alias source_john=". ~/.john_aliases.sh"




function tmx_send () {
   tmux synchronize-panes on
   "$@"
   tmux synchronize-panes off
}

function define() {
   [[ -z $1 ]] && echo "USAGE: Enter one word." && return
   local word="{$1}"
   curl -s https://api.dictionaryapi.dev/api/v2/entries/en/${word} | jq '.[] | [.word, .meanings[].definitions[].definition]'
}


function cdp () {
   [[ -z $1 ]] && cd ~/Programming/ && return
   echo ${1}
   cd ~/Programming/${1^}
}

function dcbh() {
   sudo docker compose -f /home/phaze/Programming/HackTheBox/bloodhound/docker-compose.yml "$@"
}

function qnotes() {
   local input_file=$(find ~/Documents/knowledge_vault/Hacking/ -type f | fzf --preview "batcat --style numbers,changes --color=always {} | head -n 500")
   # local input_file=$(find ~/Documents/knowledge_vault/Hacking/ -type f | fzf --preview "glow -p {}")
   echo $input_file
   [[ -z $input_file ]] && return 1
   batcat "${input_file}"
}


function tldredit() {
   local note_path=~/Documents/knowledge_vault/tldr_notes/
   local input_file=$(find "${note_path}" -type f | fzf --preview "batcat --color=always {}")
   [[ -z $input_file ]] && return 1
   [[ -f $input_file ]] && vim $input_file
}

function tldrnew() {
   local note="${1}"
   local patch="${2}"
   [[ ! -z $patch ]] && patch='patch.md'
   [[ -z $patch ]] && patch='page.md'
   local note_path=~/Documents/knowledge_vault/tldr_notes/
   local exists=$(ls ${note_path}${note}.${patch})
   if [[ ! -z $exists ]]; then
      echo "[[ Note: $note.$patch.md Exists! Try tldredit ]]"
      return 1
   fi
   nvim "${note_path}${note}.${patch}"


}

function timer () {
   declare -i seconds="$1"
   declare start="$(($(date +%s) + $seconds))"
   while [[ $start -ge $(date +%s) ]]; do
      declare time=$(( $start - $(date +%s)))
      printf '%s\r' "$(date -u -d "@$time" +%H:%M:%S)"
   done
}

export EDITOR="nvim"
export TUNIP=$(ip -j -p a | jq '.[] | select(.ifname == "tun0") | .addr_info[] | select(.family == "inet") | .local' | tr -d '"')
