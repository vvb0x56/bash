
function mkcd() { mkdir "$1"; cd "$1"; }

function cdls() { cd $1; ls; }

if [ "$OSTYPE" == "darwin15" ]; then
    function te() { open -a TextEdit $1; }
    function vnc () { open -a VNC_Viewer; }
fi
