## Exports ##
export EDITOR="nvim"
export MY_NOTES_PATH="$HOME/notes/"
export MY_PENTEST_NOTES="$HOME/notes/knowledge_vault/Pentesting/"


# some more ls aliases
alias ls='exa'
alias li="exa --icons"
alias ll='exa -alF'
alias la='exa -A'
alias l='exa -CF'


alias py="python3"
alias v="nvim"
alias vim="nvim"
alias ipy="ipython3"
alias tcopy="xclip -sel clip -i -d ':0'"
alias tpaste="xclip -sel clip -o -d ':0'"
alias bat="batcat"
alias nc="ncat"
alias john="/opt/john/run/john"
alias tf="terraform"

# Time #
alias utc="date -u '+%Y-%m-%d %H:%M:%S'"
alias dtpdate="date +%Y-%m-%d\ %H:%M:%S.%N"

# Configs #
alias vimcfg="nvim ~/.config/nvim/init.lua"
alias i3cfg="nvim ~/.config/i3/config"
alias bashcfg="nvim ~/.bashrc && source ~/.bashrc"
alias tmuxcfg="nvim ~/.config/tmux/tmux.conf"
alias aliascfg="nvim ~/.bash_aliases && source ~/.bash_aliases"
alias ghostcfg="nvim ~/.config/ghostty/config"
alias i3statuscfg="nvim ~/.config/i3status-rust/config.toml"

#Weather
alias weather="curl wttr.in"


# Notes #
alias hnotes="cd ~/notes/knowledge_vault/Hacking/"
alias tdcd="cd ~/notes/tldr_notes/"

# #HacktheBox
alias htb="cd ~/hacking/HTB/"
alias htba="sudo openvpn ~/.hackthebox/academy.ovpn& >& /dev/null && echo '[Academy Connection Successful]"
alias htbs="sudo openvpn ~/.hackthebox/seasonal.ovpn; . ~/.bashrc"
alias htbl="sudo openvpn ~/.hackthebox/lab.ovpn; . ~/.bashrc"
alias copyflags="cat user.flag | tcopy; sleep 3; cat root.flag| tcopy"
alias pandoctmpls="cd /usr/share/haskell-pandoc/data/templates/"

# Hack Tools #
# alias john="/opt/john/run/john"
# alias zip2john="/opt/john/run/zip2john"
# alias source_john=". ~/.john_aliases.sh"




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

fastmap() {
   host="${1}"
   path="${2}"
   if [[ -z "$path" ]]; then
      nmap -vv -sCV -Pn -T4 --min-rate 1000 -p- "$host"
   else
      nmap -vv -sCV -oA "$path" -Pn -T4 --min-rate 1000 -p- "$host"
   fi

}


function cdp () {
   [[ -z $1 ]] && cd ~/programming/ && return
   echo ${1}
   cd ~/programming/${1^}
}

function bhup() {
   bh_yml=/opt/bloodhound/docker-compose.yml
   [[ ! -f $bh_yml ]] && echo "[-] YAML file not in destination: $bh_file" && return 1
   docker compose ls | grep -q blood && echo '[+] Bloodhound already running!'&&  return 0
   docker compose -f $bh_yml up -d
}

function add_to_hosts() {
   [[ -z $1 ]] && echo 'Usage: <ip> <domain> to add a box to HTB boxes' && return
   local ip=$1
   local domain=$2
   if grep -q $ip /etc/hosts; then
      sudo sed -i "/$ip/s/[[:space:]]$domain\$//; /$ip/s/\$/ ${domain}/" /etc/hosts
   else
      sudo sed -i "/HTB Boxes/a${ip}  ${domain}" /etc/hosts
   fi
}

# function qnotes() {
#    local input_file=$(find ~/notes/knowledge_vault/Hacking/ -type f | fzf --preview "bat --style numbers,changes --color=always {} | head -n 500")
#    # local input_file=$(find ~/Documents/knowledge_vault/Hacking/ -type f | fzf --preview "glow -p {}")
#    echo $input_file
#    [[ -z $input_file ]] && return 1
#    batcat "${input_file}"
# }


function tldredit() {
   local note_path=~/notes/tldr-notes/
   local input_file=$(find "${note_path}" -maxdepth 1 -type f  | fzf --preview "bat --color=always {}")
   [[ -z $input_file ]] && return 1
   [[ -f $input_file ]] && vim $input_file
}

function tldrnew() {
   local note="${1}"
   local patch="${2}"
   [[ ! -z $patch ]] && patch='patch.md'
   [[ -z $patch ]] && patch='page.md'
   local note_path=~/notes/tldr-notes/
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

function TUNIP () {
    export TIP=$(ip -j -p a | jq '.[] | select(.ifname == "tun0") | .addr_info[] | select(.family == "inet") | .local' | tr -d '"')
    printf $TIP
}
