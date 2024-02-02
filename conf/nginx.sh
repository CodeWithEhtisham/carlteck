#!/bin/bash

# Check for sites-available
if [ ! -d "/etc/nginx/sites-available" ]
then
    echo "Directory does not exist. Creating one."
    mkdir -p /etc/nginx/sites-available
    echo "Directory created"
    cp -rf ./conf/carlteck /etc/nginx/sites-available/carlteck
else
    cp -rf ./conf/carlteck /etc/nginx/sites-available/carlteck
fi

# Make the link to activate nginx configuration
sudo ln -s /etc/nginx/sites-available/carlteck /etc/nginx/sites-enabled/