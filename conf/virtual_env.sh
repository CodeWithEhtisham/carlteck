#!/bin/bash

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
    python3.8 -m venv env
    echo "Virtual environment created."
else
    echo "Virtual environment already exists."
fi
echo $PWD

# Activating the virtual environment
source ./env/bin/activate