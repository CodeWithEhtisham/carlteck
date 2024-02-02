#!/bin/bash

# Check for the socket file
sudo cp -rf ./conf/carlteck.socket /etc/systemd/system/carlteck.socket

# Check for the service file
sudo cp -rf ./conf/carlteck.service /etc/systemd/system/carlteck.service

# Start / Enable the service
sudo systemctl enable --now carlteck