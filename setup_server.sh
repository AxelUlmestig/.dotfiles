#!/bin/sh
set -ex

DIR=$( cd $( dirname $BASH_SOURCE[0] ) && pwd )
NGINX_PATH=/etc/nginx
NGINX_CONF_PATH="$NGINX_PATH"/nginx.conf

sudo apt update && sudo apt install nginx

sudo rm -f $NGINX_CONF_PATH
sudo ln -s $DIR/server/nginx.conf $NGINX_CONF_PATH

sudo nginx -t
sudo systemctl restart nginx

# run certbot to update certificates if necessary
# https://certbot.eff.org/instructions?ws=nginx&os=ubuntufocal
