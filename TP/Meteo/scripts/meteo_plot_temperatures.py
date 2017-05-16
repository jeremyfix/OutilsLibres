#!/usr/bin/python3 -u
# -*- coding: utf-8 -*-


import sys
import os
import matplotlib.pyplot as plt
import datetime
from mpl_toolkits.basemap import Basemap
from scipy.interpolate import griddata
import numpy as np
import fileinput

#count = 0

sys.stderr.write("Python script is waiting from stdin\n")
sys.stderr.flush()
#for line in fileinput.input():
while(True):
    line = sys.stdin.readline()
    if(line == ''):
        break

    # We receive the datafile from the input
    # which is something like : /path/to/ddMMYYYY.txt
    
    datafile = line.rstrip('\n')
    filename = os.path.basename(datafile)
    
    #print(datafile)
    #print(filename)
    date = datetime.datetime.strptime(filename.split('.')[0], "%d%m%Y")

    output_filename = "raw_images/%s.png" % date.strftime("%d%m%Y")

    # Load the data 
    data = np.loadtxt(datafile)

    latitudes = data[:,1]
    longitudes = data[:,2]
    # Temperatures are in °F, we convert them into °C
    values = (data[:,3] - 32) / 1.8


    m = Basemap(projection='cyl',
                llcrnrlat=25,urcrnrlat=50,
                llcrnrlon=-130,urcrnrlon=-60,resolution='l')

    x, y = m(longitudes, latitudes)
    min_x, max_x = x.min(), x.max()
    min_y, max_y = y.min(), y.max()
    
    # Interpolate the measures and plot them over the map
    N_samples = 200

    # Create a mesh on which to interpolate the datapoints
    X_mesh, Y_mesh = np.meshgrid(np.linspace(min_x, max_x, N_samples), 
                                 np.linspace(min_y, max_y, N_samples))
    points = np.zeros((data.shape[0],2))
    points[:,0] = x
    points[:,1] = y
    Z_mesh = griddata(points, values, (X_mesh, Y_mesh), method='linear')
    
    # Remove the ocean data points
    #f = lambda x,y:not m.is_land(x,y)
    #test_not_is_land = np.vectorize(f)
    #mask = test_not_is_land(X_mesh, Y_mesh)
    #Z_mesh[mask] = np.nan

    ##############
    # Plot the map
    fig = plt.figure()
    m.drawcoastlines()
    cs = m.contourf(X_mesh, Y_mesh, Z_mesh, np.linspace(-40,40,21), alpha=0.7)

    #plt.title(date.strftime("%d %B %Y"))
    
    from mpl_toolkits.axes_grid1 import make_axes_locatable
    divider = make_axes_locatable(plt.gca())
    cax = divider.append_axes("bottom", "5%", pad="3%")
    plt.clim(-40,40)
    plt.colorbar(cs, cax=cax, orientation='horizontal')

    plt.savefig(output_filename, bbox_inches='tight')
    sys.stderr.write("[plot_temperatures.py] %s generated for %s" % (output_filename, date) + "\n")
    sys.stdout.write("%s\n" % output_filename)
    #count = count + 1
    #plt.show()

    plt.close(fig)
