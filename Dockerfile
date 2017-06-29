FROM nginx:1.13-alpine

COPY default.conf.template /etc/nginx/conf.d/default.conf.template
COPY 502.html /usr/share/nginx/html/502.html
COPY index.html.template /usr/share/nginx/html/index.html.template
COPY wrapper.sh /wrapper.sh

ENV DOMAIN=example.com SUB_DOMAIN=jenkins

CMD [ "/wrapper.sh" ]
