FROM ubuntu:latest
LABEL maintainer="joelnbarnham@gmail.com"

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install --no-install-recommends \
		wget \
	&& \
	apt-get -y autoremove && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	:

VOLUME /debs
WORKDIR /debs

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
