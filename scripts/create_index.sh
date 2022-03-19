#!/bin/bash -e
# create an index.html file if there isn't one

THIS_DIR=$( dirname ${BASH_SOURCE[0]} )
pageName=$1

[ -z $( find $THIS_DIR/../src -name index.html ) ] && cp $THIS_DIR/../src/$pageName.html $THIS_DIR/../src/index.html
