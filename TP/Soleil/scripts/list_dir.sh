#!/bin/bash

if [ $# != 1 ]
then
    echo "Usage $0 dir"
    exit 1
fi

mydir=$1

for file in $1/*
do
    if [[ -f $file ]]
    then
	echo $file
    fi
done
