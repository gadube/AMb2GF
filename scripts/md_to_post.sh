#!/bin/bash -e
# convert post with custom css but no template

FILENAME=$2
STYLE=$1

if [ $# -ne 2 ]
then
    echo "Usage: ./md_to_post.sh [THEME|STYLE] [MD_FILE]"
    exit 1
fi

sed -i "s/date:.*/date: $(date "+%r %Z %B %d, %Y")/g" $FILENAME
pandoc --read=markdown --css=blog.css --standalone --listings --highlight-style $STYLE $FILENAME
