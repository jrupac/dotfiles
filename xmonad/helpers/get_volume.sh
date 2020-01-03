#!/bin/bash

ret=`amixer sget Master,0`

if [[ -z `echo $ret | grep "off"` ]]; then
    echo $ret | grep -o -P "[0-9]*\%"
else 
    echo "OFF"
fi
