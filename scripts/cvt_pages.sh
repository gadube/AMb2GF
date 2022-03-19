#!/bin/bash -e
# convert pages in the pages directory to an html doc

THIS_DIR=$( dirname ${BASH_SOURCE[0]} )

for page in $( ls -1 $THIS_DIR/../pages )
do
echo "Converting $page"
$THIS_DIR/cvt_page.sh $THIS_DIR/../pages/$page ${page%%.*} > $THIS_DIR/../src/${page%%.*}.html

done
