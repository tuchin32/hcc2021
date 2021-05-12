#!/bin/bash

if [ ! "$1" ]; then
    echo "Default port is 5900"
    x11vnc -display :0 -rfbauth ~/.vnc/passwd -rfbport 5900 -loop -shared
else
    echo "Your port is $1"
    x11vnc -display :0 -rfbauth ~/.vnc/passwd -rfbport "$1" -loop -shared
fi


