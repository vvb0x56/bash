#!/usr/bin/env bash

#AFORISM=`curl -s --connect-timeout 1  -X POST -d "method=getQuote&format=text&lang=ru" http://api.forismatic.com/api/1.0/`

AFORISM=`/Users/mac/go/src/aforism/main`

SHUF_BIN="shuf"
COWS_DIR="/usr/share/cowsay/cows"

if [ "$(uname)" == "Darwin" ]; then
    SHUF_BIN="gshuf"
    COWS_DIR="/usr/local/Cellar/cowsay/3.03/share/cows"
fi

if [ -z "$AFORISM" ]; then
    AFORISM=`$SHUF_BIN -n 1 ~/Documents/aforism.md`
fi

cowsay -f $(ls -1 $COWS_DIR | $SHUF_BIN -n 1) "$AFORISM" | lolcat
