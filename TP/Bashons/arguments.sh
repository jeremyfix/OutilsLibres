#!/bin/bash

echo "J'ai bien reçu $# arguments"

if [ $# != 0 ]
then
    echo "Liste des arguments : "
    for i in $@; do
	echo "$i"
    done
else
    echo " donc rien à lister"
fi 

