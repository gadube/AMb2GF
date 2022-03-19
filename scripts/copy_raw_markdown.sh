#!/bin/bash -e
# copy markdown source into a <pre> tag and add to files. this is used to make raw source available

mkdir -p files/blog
rm -rf files/blog/*
for f in $(ls -1 blog/*.md)
do
    filebase=$(basename $f)
    cp -- "$f" "files/blog/${filebase%.md}.html"
    echo "<pre>" | cat - files/blog/${filebase%.md}.html > tmp && mv tmp files/blog/${filebase%.md}.html
    echo "</pre>" >> files/blog/${filebase%.md}.html
done
