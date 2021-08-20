#!/usr/bin/env bash

{

alias cmd='f(){ a=$* && (${a}); }; f'

alias diffop='f(){ a=$1 && b=$2 && diff $1 < ${b}; };'

alias ll='ls -lht'

alias la='ls -lhta'

alias untar='tar -zxvf'

alias unjar='jar xvf'

alias wget='wget -c'

alias getpass='openssl rand -base64 20'

alias sha='shasum -a 256'

alias www='f(){ python -m SimpleHTTPServer $1; }; f'

alias speed='speedtest-cli --server 2406 --simple'

alias ipe='curl ipinfo.io/ip'

alias ping='ping -c 5'

alias topcpu='ps aux --sort -%cpu | head -10'

alias topmem='ps aux --sort -rss | head -10'

alias diskinfo='df -Th'

alias size='f(){ du -sTh $1* | sort -hr; }; f'

alias seek='f(){ find $1 -name $2; }; f'

alias grepstr='grep --color -Re'

alias portopen='f(){ /sbin/iptables -I INPUT -p tcp --dport $1 -j ACCEPT; }; f'

alias portclose='f(){ /sbin/iptables -I INPUT -p tcp --dport $1 -j DROP; }; f'

alias msconfig='systemctl list-unit-files --type=service | grep enabled | more'

alias now='date "+%Y-%m-%d %H:%M:%S"'

alias dockerinfo='docker stats --no-stream | sort -k8 -hr | more'

alias install='yum install -y'

alias update='yum update -y'

alias upgrade='yum upgrade -y'

alias restart='systemctl restart'

bkr() { (nohup "$@" &>/dev/null &) }

}
