FROM debian:stretch

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install --no-install-recommends \
		build-essential \
		git-core \
		libicu-dev \
		ruby \
		ruby-dev \
		zlib1g-dev \
	&& \
	gem install --no-ri --no-rdoc \
		gollum \
		github-markdown \
	&& \
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
CMD ["gollum", "--mathjax", "--port", "4567"]
