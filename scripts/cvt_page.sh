#!/bin/bash -e
# convert an individual markdown page to an html doc

FILENAME=$1

# sed while preserving timestamps
timestamp=$(stat -c %y "$1")
sed -i "s/date:.*/date: $(date "+%r %Z %B %d, %Y")/g" $FILENAME
touch -d "$timestamp" "$1"

pandoc --read=markdown --standalone --listings --template skeletons/blog_skeleton.html $FILENAME
