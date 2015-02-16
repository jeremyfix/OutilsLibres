#!/bin/bash

# On cherche toutes les lignes qui contiennent un lien vers une image
gawk '/http:\/\/.*\.jp2/ {print $2 }' 
