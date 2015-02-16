#!/bin/bash

# example d'utilisation: ./list_dir.sh images/ | ./write_date.sh ./postproc_images

# from stdin: path_to/2013_05_01__01_18_59_34__SDO_AIA_AIA_171.jpg
# to stdout: $output_dir/%05d.jpg

echoerr() { echo "$@" 1>&2; }

if [ $# != 1 ]
then
    echoerr "Usage : $0 output_dir"
    exit 1
fi

output_dir=$1

count=0

# On commence par supprimer toutes les images temporaires dans postproc_images
echoerr "Suppression de toutes les images dans postproc_images/"
rm -f $output_dir/*


while read fullpath
do
    
    filename=`basename $fullpath`
    # On réécrit le nom de fichier pour un format : DD/MM/YYYY HH:MM
    title=`echo $filename | sed 's/_[0-9]*_[0-9]*__SDO_AIA_AIA_[0-9]*//' | sed 's/.jpg//' | sed 's/__/ /'`
    title=`echo $title | sed -r 's/([0-9]*)_([0-9]*)_([0-9]*) ([0-9]*)_([0-9]*)/\3\/\2\/\1 \4:\5/'`
    #echo -ne "$title\033[0K\r" 
    # \033[0K  delete until the end of line
    # -n prevents new line
    # \r : moves the cursor to the beginning of the line
    output_filename=`printf "%05d.jpg" $count`
    count=`expr $count + 1` 
    echoerr "[write_date] Converting $filename"
    convert $fullpath -fill white -stroke white -font Candice -pointsize 20 -draw "text 0,20 '$title'"  $output_dir/$output_filename
    echoerr "[write_date] $output_filename done"
done

#

