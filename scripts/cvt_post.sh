#!/bin/bash -e
# convert post to an html doc

FILENAME=$1

# sed while preserving timestamps
timestamp=$(stat -c %y "$1")
sed -i "s/date:.*/date: $(date -d "$(stat $1 | grep "Modify" |awk -F": " '{print $2}')" "+%r %Z %B %d, %Y")/g" $FILENAME
touch -d "$timestamp" "$1"

pandoc --read=markdown --standalone --listings --template skeletons/post_skeleton.html $FILENAME
