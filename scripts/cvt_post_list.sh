#!/bin/bash -e

THIS_DIR=$( dirname ${BASH_SOURCE[0]} )
BLOG_LIST=$THIS_DIR/../blog.md

# create metadata and markdown file
[ -f $BLOG_LIST ] && rm -f $BLOG_LIST
touch $BLOG_LIST
echo "---" >> $BLOG_LIST
echo "title: Blog" >> $BLOG_LIST
echo "date:" >> $BLOG_LIST
echo "---" >> $BLOG_LIST
echo >> $BLOG_LIST
echo >> $BLOG_LIST
echo "Welcome to one of the few remaining corners of the internet specializing in **unsocial media**. That is, a space where you have to read and think about the posts without being able to capitalize on your desire to _smash that like button_. I'm using this blog as a way to improve my writing, learn about interesting things, and share thoughts and ideas with others. I will gladly accept any comments, concerns or critiques :)" >> $BLOG_LIST
echo >> $BLOG_LIST
echo "## Latest Posts" >> $BLOG_LIST
# convert recent posts
mkdir -p $THIS_DIR/../src/blog
for post in $( ls -1t $THIS_DIR/../blog | head -n 5 )
do
    $THIS_DIR/cvt_post.sh $THIS_DIR/../blog/$post > $THIS_DIR/../src/blog/${post%%.*}.html 2> /dev/null &
    echo "$post is a recent post..."
    postTitle=$(grep "title" $THIS_DIR/../blog/$post | awk -F": " '{print $2}')
    [ -z "$postTitle" ] && postTitle="${post%%.*}"
    echo "- [$postTitle](blog/${post%%.*}.html)" >> $BLOG_LIST
    echo >> $BLOG_LIST
    i=$(( $i + 1 ))
done

# add links to year headers
echo "<br>" >> $BLOG_LIST
printf "\|" >> $BLOG_LIST
for yr in $( $THIS_DIR/unique_years.sh $THIS_DIR/../blog )
do
    printf " [$yr](#posts-$yr){.bloglinks} \|" >> $BLOG_LIST
done
echo >> $BLOG_LIST
echo >> $BLOG_LIST
# convert all other posts
i=0
post=$( ls -1t $THIS_DIR/../blog | head -n 1 )
oldPostYear=$( ls -l --full-time $THIS_DIR/../blog/$post | tr "-" " " | tr -s " " | cut -d " " -f 9 )
# echo "Postyear: $oldPostYear"
[ -z "$oldPostYear" ] && oldPostYear=$(date +%Y)
echo "## Posts $oldPostYear" >> $BLOG_LIST

for post in $( ls -1t $THIS_DIR/../blog )
do
    $THIS_DIR/cvt_post.sh $THIS_DIR/../blog/$post > $THIS_DIR/../src/blog/${post%%.*}.html 2> /dev/null &
    postYear=$( ls -l --full-time $THIS_DIR/../blog/$post | tr "-" " " | tr -s " " | cut -d " " -f 9 )
    [ -z "$postYear" ] && postYear=$oldPostYear
    # echo "oldPostyear: $oldPostYear"
    echo "Postyear: $postYear"
    [ "$postYear" != "$oldPostYear" ] && {
        oldPostYear="$postYear";
        echo "## Posts $oldPostYear" >> $BLOG_LIST;
    }
    postTitle=$(grep "title" $THIS_DIR/../blog/$post | awk -F": " '{print $2}')
    [ -z "$postTitle" ] && postTitle="${post%%.*}"
    echo "- [$postTitle](blog/${post%%.*}.html)" >> $BLOG_LIST
    echo >> $BLOG_LIST
    i=$(( $i + 1 ))
done

echo "Converted $i posts..."

$THIS_DIR/cvt_page.sh $THIS_DIR/../blog.md blog > $THIS_DIR/../src/blog.html

rm $THIS_DIR/../blog.md
