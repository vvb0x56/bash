#!/usr/bin/env bash

function vertical_tab() {
    echo "--"
}

function cdk_helper1() {
    echo ".Original string:" 
    vertical_tab
    sudo grep 'Exec=.\+google-chrome.\+%U$' $1
    echo
}

function cdk_helper2() {
    echo ".Result:"
    vertical_tab
    sudo grep 'Exec=.\+google-chrome.\+%U$' $1
    echo

}

function done_helper() {
    echo "!!!Should be done here."
    echo
}

    
CHROME_DESKTOP_FILE="/usr/share/applications/google-chrome.desktop"

# In this place: 
# sed -i '/Exec=.\+google-chrome.\+%U$/ {/password/! s/%U$/--password-store=basic %U/}'
# firstly we are trying to except all strings, but such as, has: 
# "Exec=" +  "google-chrome" + "%U$" except thouse who has "password" 
# Then we just changing %U -> --password-store=basic %U
     

if [ ! -z "$1" ] && [ -f "$1" ]; then
    CHROME_DESKTOP_FILE="$1"
fi
    

if [ -f $CHROME_DESKTOP_FILE ]; then
    cdk_helper1 $CHROME_DESKTOP_FILE

    sudo sed -i '/Exec=.\+google-chrome.\+%U$/ {/password/! s/%U$/--password-store=basic %U/}' $CHROME_DESKTOP_FILE
    done_helper
        
    cdk_helper2 $CHROME_DESKTOP_FILE
    
else
    echo "There are no google-chrome.desktop file in location:"
    echo "-> $CHROME_DESKTOP_FILE"
    echo "so, please use custom:"
    echo "$ ubuntu-disable-chrome-keyring FILENAME"  
    echo    
fi


