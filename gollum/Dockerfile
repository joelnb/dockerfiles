FROM debian:buster
LABEL maintainer="joelnbarnham@gmail.com"

COPY nginx/Gemfile /opt/gollum/
WORKDIR /opt/gollum/

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install --no-install-recommends \
		build-essential \
		cmake \
		git-core \
		libicu-dev \
		libssl-dev \
		pkg-config \
		python \
		python-pip \
		ruby \
		ruby-bundler \
		ruby-dev \
		zlib1g-dev \
	&& \
	bundle install && \
	pip install docutils && \
	apt-get -y remove \
		build-essential \
		ruby-dev \
		zlib1g-dev \
	&& \
	apt-get -y autoremove && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	:

VOLUME /wiki
WORKDIR /wiki
EXPOSE 4567

RUN \
	groupadd -g 1000 gollum && \
	useradd -u 1000 -g gollum gollum && \
	chown -R gollum. /wiki && \
	:

USER gollum
# Temporary fix for https://github.com/gollum/gollum/issues/1699 until new gollum release
CMD ["ruby", "-Eutf-8", "/usr/local/bin/gollum", "--mathjax", "--port", "4567", "--css"]
