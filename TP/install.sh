#!/bin/bash

sudo apt install lynx gawk

#libopenjp2-7-dev

# In xenial, I did not find the way to install the JP2
# delegate Therefore, I use openjpeg-tools with j2k_to_image 

sudo apt-get install openjpeg-tools mplayer vlc mpv

# For basemap,
sudo apt install libgeos-3.5.0 libgeos-dev
sudo pip install https://github.com/matplotlib/basemap/archive/master.zip

