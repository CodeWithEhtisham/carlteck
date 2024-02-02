#!/bin/bash

# cd to ~
cd ~

# Install necessary packages
sudo apt update && sudo apt install python3-pip nginx curl

# Check the project root directory
#if [ ! -d "carlteck" ]
#then
#    echo "CARL directory does not exist. Creating one."
#    git clone git@github.com:CodeWithEhtisham/carlteck.git && cd carlteck
#    echo "Directory created: $PWD"
#else
#    cd carlteck
#    echo "Directory exists: $PWD"
#    git pull
#fi

# Checking if virtual environment exists
if [ ! -d "env" ]
then
    echo "Virtual environment does not exist. Creating one."
    
    if virtualenv --version &> /dev/null
    then
        echo "virtualenv is installed."
    else
        echo "virtualenv is not installed. Installing..."
        sudo apt install python3-virtualenv
        echo "Virtualenv Installed"
    fi


    # Creating a virtual environment named 'env'
    virtualenv env
    echo "Virtual environment created."
else
    echo "Virtual environment already exists."
fi

# Activating the virtual environment
source env/bin/activate

# Install dependencies
pip3 install -r ./requirements.txt

./manage.py makemigrations
./manage.py migrate

# Come out of the virtual environment
#deactivate

# Check for the socket file
if [ ! "/etc/systemd/system/gunicorn.socket" ]
then
    cp ./conf/gunicorn.socket /etc/systemd/system/gunicorn.socket
else
    sudo rm /etc/systemd/system/gunicorn.socket
    cp ./conf/gunicorn.socket /etc/systemd/system/gunicorn.socket
fi

# Check for the service file
if [ ! "/etc/systemd/system/gunicorn.service" ]
then
    cp ./conf/gunicorn.service /etc/systemd/system/gunicorn.service
else
    sudo rm /etc/systemd/system/gunicorn.service
    cp ./conf/gunicorn.service /etc/systemd/system/gunicorn.service
fi

# Start / Enable the service
sudo systemctl enable --now gunicorn.socket

# Check for sites-available
if [ ! -d "/etc/nginx/sites-available" ]
then
    echo "Directory does not exist. Creating one."
    mkdir -p /etc/nginx/sites-available
    echo "Directory created"
    cp ./conf/carlteck /etc/nginx/sites-available/carlteck
else
    rm /etc/nginx/sites-available/carlteck
    cp ./conf/carlteck /etc/nginx/sites-available/carlteck
fi

# Make the link to activate nginx configuration
sudo ln -s /etc/nginx/sites-available/carlteck /etc/nginx/sites-enabled/

sudo systemctl enable --now nginx