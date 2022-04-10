FROM alpine:3.15
LABEL maintainer="joelnbarnham@gmail.com"

RUN apk add --update \
		openssh \
	&& \
	rm -rf /var/cache/apk/* && \
	:

ENTRYPOINT ["ssh"]
