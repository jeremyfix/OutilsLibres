#!/bin/bash


echoerr() { echo "$@" 1>&2; }

if [ $# != 4 ]
then
    echo "Usage : $0 DD MM YYYY LAMBDA"
    echo "e.g. $0 07 06 2011 304"
    exit 1
fi

DD=$1
MM=$2
YYYY=$3
lambda=$4

# On crée un fichier temporaire pour stocker le dump
tmpfile=`mktemp file.XXXX`

echoerr "[get_image_list.sh] Downloading index"

#lynx -dump -listonly http://infomob.metz.supelec.fr/fix/data/aia/images/$YYYY/$MM/$DD/$lambda/ > $tmpfile
lynx -dump -listonly http://jsoc.stanford.edu/data/aia/images/$YYYY/$MM/$DD/$lambda/ > $tmpfile

echoerr "[get_image_list.sh] Reading index"

more $tmpfile

echoerr "[get_image_list.sh] Reading index done!"

rm $tmpfile -f
