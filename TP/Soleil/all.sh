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

sun_get_image_list.sh $DD $MM $YYYY $lambda         |      # on récupère tout le contenu
sun_extract_www_img_params.sh                       |      # dont on extrait les URL    
#head -5 |         # Pour du débug, on ne retient que les 5 premières images
sun_telecharge_img.sh ./raw_images                  |      # qu'on télécharge   
sun_convert_img.sh  ./images                        |      # Qu'on convertit
sun_write_date.sh  ./postproc_images                       # Dans laquelle on incruste la date et l'heure

# # On génère finalement la vidéo
sun_create_video.sh ./postproc_images ./video "${DD}_${MM}_${YYYY}"


     
    
