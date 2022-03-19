#!/bin/bash -e
# accept a directory as input and print the unique years contained in the files

DIR=$1

[ -z $DIR ] && { echo "BADNESS: No directory specified"; exit -1; }

ls -l --full-time $DIR | tr "-" " " | tr -s " " | cut -d " " -f 9 | sort -r | uniq
