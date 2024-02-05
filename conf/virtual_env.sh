#!/bin/bash

# Checking if virtual environment exists
if [ ! -d "env" ]
then
    echo "Virtual environment does not exist. Creating one."

    # Creating a virtual environment named 'env'
    python3.8 -m venv env
    echo "Virtual environment created."
else
    echo "Virtual environment already exists. Deleting..."
    sudo rm -rf ./env

    # Creating a virtual environment named 'env'
    python3.8 -m venv env
    echo "Virtual environment created."
fi
echo $PWD

# Activating the virtual environment
source ./env/bin/activate
echo "Virtual environment activated."

# Installing requirements
python3.8 -m pip install -r ./requirements.txt
echo "Requirements installed"