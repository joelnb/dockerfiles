FROM phusion/passenger-ruby24
MAINTAINER Joel Noyce Barnham <joelnbarnham@gmail.com>

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get -y upgrade -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" && \
	apt-get -y install -o Dpkg::Options::="--force-confdef" -o Dpkg::Options::="--force-confold" \
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
	apt-get autoremove -y && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	mkdir /wiki && \
	chown -R app. /wiki && \
	:

ENV GOLLUM_DIR=/wiki
VOLUME /wiki
WORKDIR /wiki
EXPOSE 80

COPY gollum /etc/nginx/sites-available/
COPY config.ru /opt/gollum/

RUN \
	rm -f /etc/service/nginx/down && \
	ln -s /etc/nginx/sites-available/gollum /etc/nginx/sites-enabled/ && \
	rm /etc/nginx/sites-enabled/default && \
	groupadd -g 1000 gollum && \
	useradd -u 1000 -g gollum gollum && \
	chown -R gollum. /wiki && \
	:
