#!/bin/bash

# Set ssh service to listen on 2222.
sudo /bin/sed -i.bak 's/Port 22/Port 2222/' /etc/ssh/sshd_config

sudo service ssh restart
