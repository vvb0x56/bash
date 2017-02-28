
function mkcd() { mkdir "$1"; cd "$1"; }

function cdls() { cd $1; ls; }

if [ "$(uname)" == "Darwin" ]; then
    function textedit() { open -a TextEdit $1; }
fi
