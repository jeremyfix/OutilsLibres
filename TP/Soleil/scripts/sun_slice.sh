#!/bin/bash

# example d'utilisation: ./list_dir.sh images/ | ./sun_slice.sh ./sliced_images

# from stdin: path_to/2013_05_01__01_18_59_34__SDO_AIA_AIA_171.jpg
# to stdout: $output_dir/%05d.jpg

echoerr() { echo "$@" 1>&2; }

if [ $# != 1 ]
then
    echoerr "Usage : $0 output_dir"
    exit 1
fi

output_dir=$1

if [ ! -d $output_dir ]; then
    echo "video does not exist, I'm creating it"
    mkdir $output_dir
fi

# On commence par supprimer toutes les images temporaires dans postproc_images
echoerr "Suppression de toutes les images dans $output_dir"
rm -f $output_dir/*


while read fullpath
do
    filename=`basename $fullpath`
    output_filename=$output_dir/$filename

    echoerr "[slice] Slicing $filename"
	convert -gravity South -crop 100%x50%+0+0 +repage $fullpath $output_filename
    echo $output_filename
    echoerr "[slice] $output_filename done"
done

#

