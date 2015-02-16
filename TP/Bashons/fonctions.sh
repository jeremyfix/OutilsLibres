#!/bin/bash

function compte {
    if [ $# != 1 ]
    then
	echo "Oups: nombre invalide d'arguments" 1>&2
	echo 0
    else
	echo -n $1 | wc -m 
    fi;
}

str="ma chaine de caractères"
a=`compte "$str"`
echo "La chaîne \"$str\" contient  $a caractères"
