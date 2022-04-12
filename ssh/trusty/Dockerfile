FROM ubuntu:14.04.5
LABEL maintainer="joelnbarnham@gmail.com"

RUN \
	apt-get update -q && \
	apt-get upgrade -qy && \
	apt-get install -qy ssh && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	:

ENTRYPOINT ["ssh"]
