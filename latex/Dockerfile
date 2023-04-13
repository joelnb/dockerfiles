FROM ubuntu:22.04
LABEL maintainer="joelnbarnham@gmail.com"

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update -q && \
	apt-get upgrade -qy && \
	apt-get install -qy --no-install-recommends \
		fontconfig \
		lmodern \
		pandoc \
		texlive \
		texlive-fonts-extra \
		texlive-xetex \
	&& \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	:

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update -q && \
	apt-get upgrade -qy && \
	apt-get install -qy --no-install-recommends \
		ttf-dejavu \
	&& \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	:

WORKDIR /data
VOLUME ["/data"]
