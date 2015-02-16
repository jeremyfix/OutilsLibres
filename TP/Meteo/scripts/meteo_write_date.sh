#!/bin/bash

count=0
while read -r fullpath
do 
    filename=`basename $fullpath`
    title=`echo $filename | sed -r 's/([0-9]{2})([0-9]{2})([0-9]{4}).png/\1\/\2\/\3/'`
    output_filename=`printf "Images/%05d.png" $count`
    convert $fullpath -gravity South  -extent 640x300 -fill black -stroke black -font Candice -pointsize 20 -draw "text 0, 280 '$title'" $output_filename
    count=`expr $count + 1` 
done