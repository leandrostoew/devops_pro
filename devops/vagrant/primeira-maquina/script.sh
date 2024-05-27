#!/bin/bash

apt update
apt install nginx -y 
service nginx restart
