#!/bin/bash

AFORISM=`/usr/bin/curl -s --connect-timeout 1  -X POST -d "method=getQuote&format=text&lang=ru" http://api.forismatic.com/api/1.0/`

if [ -z "$AFORISM" ]; then
	AFORISM=`/usr/local/bin/gshuf -n 1 ~/Documents/aforism.md`
fi

/usr/local/bin/cowsay -f $(ls -1 /usr/local/Cellar/cowsay/3.03/share/cows | /usr/local/bin/gshuf -n 1) "$AFORISM" | /usr/local/bin/lolcat
