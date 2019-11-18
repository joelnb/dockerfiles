FROM ruby:2.6-alpine3.10
LABEL maintainer="joelnbarnham@gmail.com"

RUN \
    apk add --no-cache --virtual deps libc-dev libffi-dev linux-headers build-base && \
    apk add --no-cache git && \
    gem install travis -v 1.8.10 --no-document && \
    gem cleanup && \
    apk del --purge deps && \
    rm -rf /usr/lib/ruby/gems/*/cache/* && \
    rm -rf /var/cache/apk/* /tmp/* && \
    :

RUN \
    addgroup -g 1000 travis && \
    adduser -g 1000 travis -G travis -h /home/travis -D -g "Travis CLI User" && \
    :

WORKDIR /home/travis
USER travis
ENTRYPOINT ["travis"]
