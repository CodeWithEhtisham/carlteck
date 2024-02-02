#!/bin/bash

# Check for the socket file
cp -rf ./conf/gunicorn.socket /etc/systemd/system/gunicorn.socket

# Check for the service file
cp -rf ./conf/gunicorn.service /etc/systemd/system/gunicorn.service

# Start / Enable the service
sudo systemctl enable --now gunicorn.socket