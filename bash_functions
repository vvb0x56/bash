# for memory, some IFS magic:
# - IFSBACK=$IFS; IFS=$'\n'; echo "$IFS" | cat -vte; IFS=$IFSBACK;
# - OLD_IFS=$IFS; IFS=$(echo -ne "\n\b");


function mkcd() { mkdir "$1"; cd "$1"; }

function cdls() { cd $1; ls; }


# FIX MAC FROM THIS FORM - 0:e:c6:c3:36:8c 
#                TO THIS - 00:0e:c6:c3:36:8c
function normalize_mac_address() {
    local NEW_MAC_ADDR="";

    for octet in $(echo $MAC_ADDR | tr ':' '\n'); 
      do 
        octet_len=$(echo "$octet" | awk "{ print length }"); 
        new_mac_addr_len=$(echo "$NEW_MAC_ADDR" | awk "{ print length }");

        # CHECK IF NEED TO INSERT ':' AFTER OCTET
        if [ "$new_mac_addr_len" -ge "2" ];
          then
            NEW_MAC_ADDR="$NEW_MAC_ADDR:"
        fi

        # IF OCTECT CONTENT ONLY 1 SYM f.e ':0:'
        if [ "$octet_len" -eq "1" ];
          then
            NEW_MAC_ADDR="$NEW_MAC_ADDR""0""$octet"
          else   
            NEW_MAC_ADDR="$NEW_MAC_ADDR$octet";
        fi
    done;

    MAC_ADDR=$NEW_MAC_ADDR;
}


# GET VENDOR OF THE MAC
function mac_vendor {
    if [ -n "$1" ]; then
        MAC_ADDR="$1";
        normalize_mac_address;
        echo $(curl -s -X GET https://macvendors.co/api/$MAC_ADDR/csv | cut -d\" -f 2);
    fi
}


function lsgrep() {
    if [ -n "$@" ]; then
        ls -1 | grep $@;
    fi
}

function hex2dec() {
    if [ -n "$1" ]; then
        HEX="$1";
        printf "%d\n" "$((16#$HEX))";
    fi
}

function long_filenames() {
    OLD_IFS=$IFS; IFS=$(echo -ne "\n\b");

    if [ -n "$1" ] && [ -d "$1" ]; 
      then 
        DIR=$1;
      else
        DIR=$PWD;   
    fi

    for filename in $(ls -1 $DIR); do 
        len=$(echo $filename | wc -c); 
        if [ $len -gt 40 ]; then 
            echo $filename: $len; 
        fi; 
    done;
    IFS=$OLD_IFS;
}


if [ "$OSTYPE" == "darwin19" ]; then
    function canonical_update_repo() {
        OLD_DIR=$PWD;
        cd /Users/mac/Trash/Canonical/cpe_fce/fce-templates && git pull;
        cd /Users/mac/Trash/Canonical/cpe_fce/cpe-foundation && git pull; 
        echo $(date) > /Users/mac/Trash/Canonical/cpe_fce/date.txt;
        cd $OLD_DIR;
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
    function nas() { ftp ftp://xxxxxxxxxxxxxx@10.199.30.10/fg-vvb/; }

    function put-to-nas() {
        if [ -z "$1" ]; then
            echo "Usage: put-to-nas FILE";
        else
            curl -T $1 ftp://xxxxxxxxxxxxxx@10.199.30.10/fg-vvb/;
        fi
    }

    function get-from-nas() {
        if [ -z "$1" ]; then
            echo "Usage: get-from-nas FILE";
        else
            wget --user=fg-vvb --password='xxxxxxxxxxx' ftp://10.199.30.10/fg-vvb/$1;
        fi
    }
fi
