#!/usr/bin/python3
# -*- coding: utf-8 -*-

import matplotlib.pyplot as plt
from mpl_toolkits.basemap import Basemap

m = Basemap(projection='cyl',
            llcrnrlat=25,urcrnrlat=50,
            llcrnrlon=-130,urcrnrlon=-60,resolution='c')


##############
# Plot the map
fig = plt.figure()
m.drawcoastlines()
plt.savefig("output.png", bbox_inches='tight')
plt.show()
