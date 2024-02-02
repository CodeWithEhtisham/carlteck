#!/bin/bash

# Check for sites-available
if [ ! -d "/etc/nginx/sites-available" ]
then
    echo "Directory does not exist. Creating one."
    mkdir -p /etc/nginx/sites-available
    echo "Directory created"
    sudo cp -rf ./conf/carlteck /etc/nginx/sites-available/carlteck
else
    sudo cp -rf ./conf/carlteck /etc/nginx/sites-available/carlteck
fi

# Make the link to activate nginx configuration
if [ ! "/etc/nginx/sites-enabled/carlteck" ]
then
    sudo ln -s /etc/nginx/sites-available/carlteck /etc/nginx/sites-enabled/
else
    sudo rm /etc/nginx/sites-enabled/carlteck
    sudo ln -s /etc/nginx/sites-available/carlteck /etc/nginx/sites-enabled/
fi