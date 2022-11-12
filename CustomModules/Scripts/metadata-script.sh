#!/usr/bin/bash

#################### Installing apache2 ####################

sudo su -
apt update -y
apt install apache2 -y
systemctl start apache2
systemctl enable apache2