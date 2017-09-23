FROM yandex/gixy
COPY files/default.conf.template /etc/nginx/conf.d/default.conf.template
RUN gixy /etc/nginx/conf.d/default.conf.template

FROM nginx:1.13-alpine
COPY files/default.conf.template /etc/nginx/conf.d/default.conf.template
COPY files/502.html /usr/share/nginx/html/502.html
COPY files/index.html.template /usr/share/nginx/html/index.html.template
COPY files/wrapper.sh /wrapper.sh

ENV DOMAIN=example.com SUB_DOMAIN=jenkins

CMD [ "/wrapper.sh" ]
