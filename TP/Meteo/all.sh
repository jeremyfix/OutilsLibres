#!/bin/bash

# First, we clean up the directories
./clean.sh

meteo_get_date.sh | 
meteo_generate_dates.py |
meteo_get_data.sh |
meteo_plot_temperatures.py |
meteo_write_date.sh

# We now generate the movie from all the images
avconv -y -r 100 -i Images/%05d.png Videos/out.mp4 
