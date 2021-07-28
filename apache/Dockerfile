FROM joelnb/dumb-init-alpine:3
LABEL maintainer="joelnbarnham@gmail.com"

RUN \
	apk add --no-cache \
		apache2 \
		apache2-utils \
	&& \
	:

CMD ["/usr/sbin/httpd", "-DFOREGROUND"]
