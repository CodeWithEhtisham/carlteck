#!/bin/bash

# Install necessary packages
sudo apt update && sudo apt install python3-pip nginx curl

# Check the project root directory
if [ ! -d "carlteck" ]
then
    echo "CARL directory does not exist. Creating one."
    git clone git@github.com:CodeWithEhtisham/carlteck.git && cd carlteck
    echo "Directory created: $PWD"
else
    cd carlteck
    echo "Directory exists: $PWD"
fi

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

# Pull the latest code from the repository
git pull

# Install dependencies
pip3 install django gunicorn

./manage.py makemigrations && ./manage.py migrate

sudo ufw allow 8000

