#some usefull aliases

alias c='clear';
alias mkdir='mkdir -pv';
alias ftp='/usr/local/opt/inetutils/libexec/gnubin/ftp'
alias ip='ls -1 ~ | grep "\.ip$"'
alias pw='ls -1 ~ | grep "\.pw$"'
alias protoc='/Users/mac/Downloads/protoc-3.7.1-osx-x86_64/bin/protoc'
alias mftp='/Users/mac/Trash/mftp/mftp/mftp'
alias vim='mvim'
alias vi='mvim'

if [ "$(uname)" == "Linux" ]; then
    alias apt='sudo apt';
    alias ports='netstat -tulpan';
    alias upgrade='sudo apt-get update && sudo apt-get upgrade';
    alias vmstat='vmstat -w';
fi
