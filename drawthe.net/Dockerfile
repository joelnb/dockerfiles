FROM joelnb/dumb-init-alpine
LABEL maintainer="joelnbarnham@gmail.com"

RUN \
    apk add --no-cache \
        git \
        nginx \
    && \
    git clone --depth 1 https://github.com/cidrblock/drawthe.net.git /var/www/html && \
    mkdir -pv /opt/httpd/conf/ && \
    :

COPY ["nginx.conf", "/etc/nginx/nginx.conf"]

ENTRYPOINT ["dumb-init", "--"]
CMD ["nginx", "-c", "/etc/nginx/nginx.conf"]
