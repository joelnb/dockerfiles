FROM debian:11
LABEL maintainer="joelnbarnham@gmail.com"

COPY Gemfile /opt/gollum/
WORKDIR /opt/gollum/

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get -y update && \
	apt-get -y install --no-install-recommends \
		dirmngr \
		gnupg \
		apt-transport-https \
		ca-certificates \
	&& \
	apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7 && \
	echo 'deb https://oss-binaries.phusionpassenger.com/apt/passenger bullseye main' > /etc/apt/sources.list.d/passenger.list && \
	apt-get -y update && \
	apt-get -y upgrade && \
	apt-get -y install --no-install-recommends \
		build-essential \
		cmake \
		git-core \
		libicu-dev \
		libnginx-mod-http-passenger \
		libssl-dev \
		nginx \
		pkg-config \
		python-is-python3 \
		python3 \
		python3-pip \
		ruby \
		ruby-bundler \
		ruby-dev \
		zlib1g-dev \
	&& \
	bundle install && \
	pip install docutils && \
	apt-get -y remove \
		apt-transport-https \
		build-essential \
		ruby-dev \
		zlib1g-dev \
	&& \
	apt-get -y autoremove && \
	apt-get clean && \
	rm /etc/apt/sources.list.d/passenger.list && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	:

VOLUME /wiki
WORKDIR /wiki
EXPOSE 80

ENV GOLLUM_DIR=/opt/gollum
CMD ["nginx", "-g", "daemon off;", "-c", "/etc/nginx/nginx.conf"]

RUN \
	groupadd -g 1000 gollum && \
	useradd -u 1000 -g gollum gollum && \
	chown -R gollum. /wiki && \
	:

COPY gollum /etc/nginx/sites-available/
COPY nginx.conf /etc/nginx/
COPY config.ru /opt/gollum/

RUN \
	ln -s /etc/nginx/sites-available/gollum /etc/nginx/sites-enabled/ && \
	rm /etc/nginx/sites-enabled/default && \
	passenger-config validate-install && \
	:
