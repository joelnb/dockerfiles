FROM alpine:3.19
LABEL maintainer="joelnbarnham@gmail.com"

RUN apk add --update \
		openssh \
	&& \
	rm -rf /var/cache/apk/* && \
	:

ENTRYPOINT ["ssh"]
