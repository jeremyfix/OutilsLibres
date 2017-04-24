#!/bin/bash

echoerr() { echo "$@" 1>&2; }

if [ $# != 1 ]
then
    echoerr "Usage : $0 output_dir "
    exit 1
fi

output_dir=$1

# from stdin: path_to/2013_05_01__01_18_59_34__SDO_AIA_AIA_171.jp2
# to stdout: $output_dir/2013_05_01__01_18_59_34__SDO_AIA_AIA_171.jpg

while read line
do
    
    status=`echo $line | cut -d" " -f1`
    fullpath=`echo $line | cut -d" " -f2`

    #echoerr "[convert_img] $status  ; $fullpath"

    # Extract the basename
    filename=`basename $fullpath`
    decoded_filename=`echo $filename | sed 's/\.jp2$/\.pgm/'`
    decoded_fullpath="$output_dir/$decoded_filename"
    output_filename=`echo $filename | sed 's/\.jp2$/\.jpg/'`
    output_fullpath="$output_dir/$output_filename"
    if [ "$status" = "NEW" ]
    then
	echoerr "[convert_img] Dealing with $fullpath"
	j2k_to_image -i $fullpath  -o $decoded_fullpath > /dev/null
	convert $decoded_fullpath -resize 10% ./scripts/soleil_gradient.jpg -clut $output_fullpath > /dev/null
	if [ $? != 0 ]
	then
	    echoerr "[convert_img] convert issued an error"
	    exit 1
	fi
	echoerr "[convert_img] $fullpath done"
    else
	echoerr "[convert_img] $output_fullpath was already done"
    fi
    echo "$output_fullpath"
    rm -f $fullpath
done
