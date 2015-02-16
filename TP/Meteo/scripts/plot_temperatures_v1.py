#!/usr/bin/python
# -*- coding: utf-8 -*-

import sys
import matplotlib.pyplot as plt
import datetime
from mpl_toolkits.basemap import Basemap
import numpy as np

if(len(sys.argv) != 2):
    print("Usage : {} datafile".format(sys.argv[0]));
    sys.exit(-1)


datafile = sys.argv[1]

# Load the data 
data = np.loadtxt(datafile)

latitudes = data[:,1]
longitudes = data[:,2]
# Temperatures are in °F, we convert them into °C
z = (data[:,3] - 32) / 1.8


m = Basemap(projection='cyl',
            llcrnrlat=25,urcrnrlat=50,
            llcrnrlon=-130,urcrnrlon=-60,resolution='l')

x, y = m(longitudes, latitudes)

##############
# Plot the map
fig = plt.figure()
m.drawcoastlines()
cs = plt.scatter(x, y, c=z)

from mpl_toolkits.axes_grid1 import make_axes_locatable
divider = make_axes_locatable(plt.gca())
cax = divider.append_axes("bottom", "5%", pad="3%")
plt.clim(-40,40)
plt.colorbar(cs, cax=cax, orientation='horizontal')


plt.savefig("output.png", bbox_inches='tight')
plt.show()
