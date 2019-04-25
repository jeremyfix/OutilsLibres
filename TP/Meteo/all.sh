#!/bin/bash

# First, we clean up the directories
./clean.sh

./scripts/meteo_get_date.sh |
./scripts/meteo_generate_dates.py |
./scripts/meteo_get_data.sh |
./scripts/meteo_plot_temperatures.py |
./scripts/meteo_write_date.sh

# We now generate the movie from all the images
#avconv -y -r 100 -i Images/%05d.png Videos/out.mp4
ffmpeg -y -r 100 -i Images/%05d.png Videos/out.mp4
