FROM alpine:3.6
LABEL maintainer="joelnbarnham@gmail.com"

ENV NOKOGIRI_USE_SYSTEM_LIBRARIES=1

RUN \
	apk add --no-cache --virtual build-deps \
		autoconf \
		bison \
		build-base \
		libffi-dev\
		libpcap-dev \
		libxml2-dev \
		libxslt-dev \
		ncurses-dev \
		postgresql-dev \
		readline-dev \
		ruby-dev \
		sqlite-dev \
		yaml-dev \
		zlib-dev \
	&& \
	apk add --no-cache \
		git \
		libxslt \
		ncurses \
		nmap \
		postgresql \
		ruby \
		ruby-bigdecimal \
		ruby-bundler \
		ruby-io-console \
		sqlite \
		subversion \
	&& \
	cd /usr/share && \
	git clone https://github.com/rapid7/metasploit-framework.git && \
	cd /usr/share/metasploit-framework && \
	bundle install && \
	apk del build-deps && \
	:

ENV PATH=$PATH:/usr/share/metasploit-framework
VOLUME ['/usr/share/metasploit-framework']

COPY entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT /usr/local/bin/entrypoint.sh
