#!/bin/bash -e
# create a new post or edit an existing one

read -p "Name of Post: " title

#grab post name
ext="${title##*.}"
[ "$ext" == "md" ] || title="$title.md"

[ -e blog/$title ] && { echo "WARNING: File already exists, editing..."; sleep 0.5; } || {
    echo "---" >> blog/$title
    echo "title: ${title%%.*}" >> blog/$title
    echo "date:" >> blog/$title
    echo "mdfile: $title" >> blog/$title
    echo "---" >> blog/$title
}
$EDITOR blog/$title
