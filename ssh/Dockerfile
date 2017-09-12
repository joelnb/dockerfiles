FROM alpine:3.6
MAINTAINER Joel Noyce Barnham <joelnbarnham@gmail.com>

RUN apk add --update \
		openssh \
	&& \
	rm -rf /var/cache/apk/* && \
	:

ENTRYPOINT ["dum", "--", "ssh"]
