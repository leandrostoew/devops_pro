#!/usr/bin/env bash
echo "Installing Apache and setting it up..."
yum install -y httpd || { echo "Failed to install httpd"; exit 1; }
if [ -d "/vagrant/html/" ]; then
    cp -r /vagrant/html/* /var/www/html/
else
    echo "Directory /vagrant/html/ does not exist."
fi
systemctl start httpd || { echo "Failed to start httpd"; exit 1; }