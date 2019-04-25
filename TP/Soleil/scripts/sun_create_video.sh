#!/bin/bash


# https://trac.ffmpeg.org/wiki/Create%20a%20video%20slideshow%20from%20images
# Impossible de trouver le libx264

if [ $# != 3 ]
then
    echo "Usage : $0 input_dir output_dir output_filename(WE)"
    exit 1
fi

input_dir=$1
output_dir=$2
output_filename_we=$3

#avconv -y -r 100 -i ${input_dir}/%05d.jpg  ${output_dir}/${output_filename_we}.mp4
ffmpeg -y -r 100 -i ${input_dir}/%05d.jpg  ${output_dir}/${output_filename_we}.mp4
