#!/bin/bash

envsubst < dot.mappings | while read l
do
    if [ -z "$l" ] ; then
        continue
    fi
    pair=`echo $l | awk '{split($0,a,":[ ]+"); print a[1],a[2]}'`
    src=$(echo $pair | cut -f1 -d' ')
    des=$(echo $pair | cut -f2 -d' ')
    if ! [ -e "$src" ]; then
        echo "$src doesn't exist. Skipping..."
        continue
    fi
    if [ -e "$des" ]; then
        echo "$des already exists. Skipping..."
        continue
    fi
    realP=`realpath $src`
    echo "$src -> $des"
    mkdir -p $(dirname $des) # ensure that the path exists
    ln -s $realP $des
done
