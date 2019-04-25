#!/bin/bash

if [ $# -lt 4 ]
then
    echo "Usage $0 DD MM YYYY lambda"
    echo "e.g. $0 07 06 2011 304"
    exit 1
fi

DD=$1
MM=$2
YYYY=$3
lambda=$4

if [ ! -d "./raw_images" ]; then
    echo "raw_images does not exist, I'm creating it"
    mkdir raw_images
fi
if [ ! -d "./images" ]; then
    echo "images does not exist, I'm creating it"
    mkdir images
fi
if [ ! -d "./postproc_images" ]; then
    echo "postproc_images does not exist, I'm creating it"
    mkdir postproc_images
fi
if [ ! -d "./video" ]; then
    echo "video does not exist, I'm creating it"
    mkdir video
fi



./scripts/sun_get_image_list.sh $DD $MM $YYYY $lambda         |      # on récupère tout le contenu
./scripts/sun_extract_www_img_params.sh                       |      # dont on extrait les URL
head -500 |         # Pour du débug, on ne retient que les 5 premières images
./scripts/sun_telecharge_img.sh ./raw_images                  |      # qu'on télécharge
./scripts/sun_convert_img.sh  ./images                        |      # Qu'on convertit
./scripts/sun_write_date.sh  ./postproc_images                       # Dans laquelle on incruste la date et l'heure

# On génère finalement la vidéo
./scripts/sun_create_video.sh ./postproc_images ./video "${DD}_${MM}_${YYYY}"




