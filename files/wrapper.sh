#!/bin/sh

if [ -f /etc/nginx/conf.d/default.conf.template ];
then
  envsubst '\$DOMAIN \$SUB_DOMAIN' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf
fi

if [ -f /usr/share/nginx/html/index.html.template ];
then
  envsubst '\$DOMAIN \$SUB_DOMAIN' < /usr/share/nginx/html/index.html.template  > /usr/share/nginx/html/index.html
fi

nginx -g 'daemon off;'
