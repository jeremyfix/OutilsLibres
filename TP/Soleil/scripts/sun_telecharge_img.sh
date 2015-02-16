#!/bin/bash

# Ce script lit depuis stdin une URL du style:
# http://jsoc.stanford.edu/data/aia/images/2013/05/01/171/2013_05_01__00_03_59_34__SDO_AIA_AIA_171.jp2
# en extrait le nom du fichier image 2013_05_01__00_03_59_34__SDO_AIA_AIA_171.jp2
# Si le fichier n'existe pas déjà dans  ./raw_images, on le télécharge
# on echo le chemin complet du fichier

echoerr() { echo "$@" 1>&2; }

if [ $# != 1 ]
then
    echoerr "Usage: $0 output_dir"
    exit 1
fi

output_dir=$1

while read line
do
    # $line contient l'URL complète.
    # on en extrait le nom du fichier image
    filename=`echo $line | awk -F/ '{ print $NF }'`
    fullpath="$output_dir/$filename"

    output_filename_convert=`echo $filename | sed 's/\.jp2/\.jpg/'`
    if [ ! -f ./images/$output_filename_convert ]
    then
	if [ ! -f $fullpath ]
	then
	    echoerr "[telecharge_img.sh] Downloading $filename"
	    wget $line -q -P $output_dir > /dev/null
	    if [ $? != 0 ]
	    then
		echoerr "[telecharge_img.sh] An error was issued by wget"
		exit 1
	    fi
	    echoerr "[telecharge_img.sh] $filename done"
	fi
	echo "NEW $fullpath"
    else
	echo "EXIST $fullpath"
	echoerr "[telecharge] $output_filename_convert already exists."
    fi
    
done

echoerr "[telecharge_img.sh] Job done ! "
