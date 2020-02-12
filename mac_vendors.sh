#!/bin/bash

SAVE_IFS=$IFS
IFS=$(echo -en "\n\b")

function normalize_mac_address() {
    local NEW_MAC_ADDR="";

    for octet in $(echo $MAC_ADDR | tr ':' '\n'); 
      do 
        octet_len=$(echo "$octet" | awk "{ print length }"); 
        new_mac_addr_len=$(echo "$NEW_MAC_ADDR" | awk "{ print length }");

        if [ "$new_mac_addr_len" -ge "2" ];
          then
            NEW_MAC_ADDR="$NEW_MAC_ADDR:"
        fi

        if [ "$octet_len" -eq "1" ];
          then
            NEW_MAC_ADDR="$NEW_MAC_ADDR""0""$octet"
          else   
            NEW_MAC_ADDR="$NEW_MAC_ADDR$octet";
        fi
    done;

    MAC_ADDR=$NEW_MAC_ADDR;
}


for arp_str in $(arp -an)
    do
        IP=$(echo $arp_str | cut -d\( -f2 | cut -d\) -f1);
        MAC_ADDR=$(echo $arp_str | cut -d $' ' -f 4);

        normalize_mac_address;

        VENDOR=$(curl -s -X GET https://macvendors.co/api/$MAC_ADDR/csv | cut -d\" -f 2);


        echo $IP $MAC_ADDR $VENDOR;
done;

IFS=$SAVE_IFS


