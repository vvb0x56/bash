
function mkcd() { mkdir "$1"; cd "$1"; }

function cdls() { cd $1; ls; }

function lsgrep() {
    if [ -n "$1" ]; then 
        ls -1 | grep $1;
    fi
}

if [ "$OSTYPE" == "darwin15" ]; then
    function te() {
        if [ -n "$1" ] && [ ! -f "$1" ]; then 
            touch $1;
        fi  
        open -a TextEdit $1; 
    }
    function vnc() { open -a VNC_Viewer; }
    function code() { open -a Visual\ Studio\ Code $1; }
fi
