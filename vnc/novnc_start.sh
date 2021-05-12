#!/bin/bash


if [ ! "$1" ]; then
    echo "Default port is 5900"
    cd ~/noVNC && ./utils/launch.sh --vnc localhost:5900
else
    echo "Your port is $1"
    cd ~/noVNC && ./utils/launch.sh --vnc localhost:"$1"
fi