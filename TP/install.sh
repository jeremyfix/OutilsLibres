#!/bin/bash

sudo apt install lynx gawk

#libopenjp2-7-dev

# In xenial, I did not find the way to install the JP2
# delegate Therefore, I use openjpeg-tools with opj_decompress

sudo apt-get install mplayer vlc mpv libopenjp2-tools

# For basemap,
sudo apt install -y libgeos-3.6.2 libgeos-dev
sudo python -m pip install https://github.com/matplotlib/basemap/archive/master.zip

