#!/bin/bash

# INIT
OUTPUT_FILE=sizes_output.txt;
SEARCH_DEPTH=6;
ROOT_DIR="/home/juju";

IFS_BACKUP=$IFS;
IFS=$(echo -ne "\n\b");


# CLEAN OUTPUT FILE
clean_file() {
    cat /dev/null > $OUTPUT_FILE;
}

# WRITE SIZE OF THE DIRECTORY TO OUTPUT FILE
get_size_for_dir() {
    for D in $(ls -d1 $1); do
        du -sh $D >> $OUTPUT_FILE;
    done;

}

# WALK THROUGH DIRECTORIES
get_sizes_for_internal_dirs_recursive() {
    if [[ $2 -ge 0 ]]; then
        DIRS=$(ls -l $1 | grep ^d | awk -F  " " 'BEGIN { result="" } { for (i=9; i<= NF; ++i) { if (i > 9) result=result" "$i; else result=$i; } printf "%s\n",result; result="" } ');
        for DIR in $DIRS; do
            get_size_for_dir "$1"/"$DIR";
            get_sizes_for_internal_dirs_recursive "$1"/"$DIR" $[$2-1]
        done;
    fi
}

# MAIN
clean_file $OUTPUT_FILE
get_sizes_for_internal_dirs_recursive $ROOT_DIR $SEARCH_DEPTH


# CLEAN UP
IFS=$IFS_BACKUP
