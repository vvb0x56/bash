# for memory, some IFS magic:
# IFSBACK=$IFS; IFS=$'\n'; echo "$IFS" | cat -vte; IFS=$IFSBACK;


function mkcd() { mkdir "$1"; cd "$1"; }

function cdls() { cd $1; ls; }


function lsgrep() {
    if [ -n "$@" ]; then
        ls -1 | grep $@;
    fi
}


if [ "$OSTYPE" == "darwin18" ]; then
    function canonical_update_repo() {
        cd /Users/mac/Trash/Canonical/cpe_fce/fce-templates && git pull;
        cd /Users/mac/Trash/Canonical/cpe_fce/cpe-foundation && git pull;
        echo $(date) > /Users/mac/Trash/Canonical/cpe_fce/date.txt;
    }

    #Open gui applications from console
    function te() {
        if [ -n "$1" ] && [ ! -f "$1" ]; then
            touch $1;
        fi
        open -a TextEdit $1;
    }

    function vnc() { open -a VNC_Viewer; }

    function code() { open -a Visual\ Studio\ Code $1; }

    function finder() {
        if [ -n "$1" ]; then
            open -a Finder $1;
        else
            open -a Finder `pwd`;
        fi
    }

    function show() {
        if [ -n "$1" ]; then
            cat ~/$1;
        else
            cat;
        fi
    }

    #Function for connect / upload / download  from Factor Group NAS server
    function nas() { ftp ftp://fg-vvb:QWEsZXC-2017\!@10.199.30.10/fg-vvb/; }

    function put-to-nas() {
        if [ -z "$1" ]; then
            echo "Usage: put-to-nas FILE";
        else
            curl -T $1 ftp://fg-vvb:QWEsZXC-2017\!@10.199.30.10/fg-vvb/;
        fi
    }
    function get-from-nas() {
        if [ -z "$1" ]; then
            echo "Usage: get-from-nas FILE";
        else
            wget --user=fg-vvb --password='QWEsZXC-2017!' ftp://10.199.30.10/fg-vvb/$1;
        fi
    }
fi
