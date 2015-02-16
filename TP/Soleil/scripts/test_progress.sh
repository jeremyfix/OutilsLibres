#!/bin/bash
for pc in $(seq 1 100); do
    echo -ne "$pc  %\033[0K\r"
    sleep 1
done
echo
