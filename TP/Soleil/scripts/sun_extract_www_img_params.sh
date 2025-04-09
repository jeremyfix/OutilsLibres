#!/bin/bash

# On cherche toutes les lignes qui contiennent un lien vers une image
gawk '/https:\/\/.*\.jp2/ {print $2 }' 
