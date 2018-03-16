FROM joelnb/dumb-init-debian:jessie
MAINTAINER Joel Noyce Barnham <joelnbarnham@gmail.com>

ENV LIBTORRENT_VERSION=0.13.6
ENV RTORRENT_VERSION=0.9.6

# Build and install rtorrent (and all dependencies)
RUN \
	build_deps=" \
		autoconf \
		automake \
		build-essential \
		cfv \
		comerr-dev \
		git \
		libcppunit-dev \
		libcurl4-openssl-dev \
		libncurses5-dev \
		libsigc++-2.0-dev \
		libssl-dev \
		libtool \
		ncurses-term \
		pkg-config \
	" && \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -q -y --no-install-recommends \
		${build_deps} \
		ca-certificates \
		curl \
		ntp \
	&& \
	git clone https://github.com/joelnb/xmlrpc-c.git /tmp/xmlrpc-c && \
	cd /tmp/xmlrpc-c && \
	./configure --disable-libwww-client --disable-wininet-client --disable-abyss-server --disable-cgi-server && \
	make -j2 && \
	make install && \
	rm -rf /tmp/xmlrpc-c && \
	curl -o /tmp/libtorrent.tar.gz http://rtorrent.net/downloads/libtorrent-${LIBTORRENT_VERSION}.tar.gz && \
	tar -xvf /tmp/libtorrent.tar.gz -C /tmp && \
	cd /tmp/libtorrent-${LIBTORRENT_VERSION} && \
	./autogen.sh && \
	./configure && \
	make -j2 && \
	make install && \
	rm -rf /tmp/libtorrent* && \
	curl -o /tmp/rtorrent.tar.gz http://rtorrent.net/downloads/rtorrent-${RTORRENT_VERSION}.tar.gz && \
	tar -xvf /tmp/rtorrent.tar.gz -C /tmp && \
	cd /tmp/rtorrent-${RTORRENT_VERSION} && \
	./autogen.sh && \
	./configure --with-xmlrpc-c && \
	make -j2 && \
	make install && \
	ldconfig && \
	rm -rf /tmp/rtorrent* && \
	cd / && \
	apt-get purge -y ${build_deps} && \
	apt-get -y autoremove && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	:

# Add caddy (personal license)
RUN \
	curl --silent --show-error --fail --location -o - "https://caddyserver.com/download/linux/amd64" \
		| tar --no-same-owner -C /usr/bin/ -xz caddy \
	&& \
	chmod 0755 /usr/bin/caddy && \
	/usr/bin/caddy -version && \
	:

# Install PHP and correct some settings
RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get install -q -y --no-install-recommends \
		php5-fpm \
		php5-cli \
	&& \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	sed 's/.*daemonize.*/daemonize = no/' -i /etc/php5/fpm/php-fpm.conf && \
	sed 's/.*upload_max_filesize.*/upload_max_filesize = 64M/' -i /etc/php5/fpm/php.ini && \
	sed 's/.*max_file_uploads.*/max_file_uploads = 200/' -i /etc/php5/fpm/php.ini && \
	sed 's/.*post_max_size.*/post_max_size = 128M/' -i /etc/php5/fpm/php.ini && \
	sed 's/.*memory_limit.*/memory_limit = 512M/' -i /etc/php5/fpm/php.ini && \
	:

# Install ruTorrent & deoendencies
RUN \
	sed -i '/^deb / s/$/ non-free/' /etc/apt/sources.list && \
	echo 'deb http://ftp.us.debian.org/debian jessie-backports main contrib non-free' > /etc/apt/sources.list.d/backports.list && \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get install -q -y --no-install-recommends \
		ffmpeg \
		mediainfo \
		rar \
		unrar \
		unzip \
		zip \
		zlib1g-dev \
	&& \
	mkdir -p /opt/www/ && \
	cd /opt/www && \
	mkdir rutorrent && \
	curl -L -O https://github.com/Novik/ruTorrent/archive/master.tar.gz && \
	tar xzvf master.tar.gz -C rutorrent --strip-components 1 && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	:

# Install supervisord to manage processes
RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get install -q -y --no-install-recommends \
		python \
		python-pip \
	&& \
	pip install supervisor && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	:

VOLUME ["/downloads", "/opt/www/rutorrent"]
ENTRYPOINT ["dumb-init", "entrypoint.sh"]
EXPOSE 80 5000 9527 55950

COPY entrypoint.sh /usr/local/bin/
COPY start-rtorrent.sh /usr/local/bin/
COPY Caddyfile /etc/
COPY supervisord.conf /etc/supervisor/supervisord.conf
COPY rtorrent.rc /root/.rtorrent.rc
COPY config.php /opt/www/rutorrent/conf/config.php

RUN \
	chmod a+x /usr/local/bin/entrypoint.sh && \
	chmod a+x /usr/local/bin/start-rtorrent.sh && \
	chown -R www-data:www-data /opt/www/rutorrent/share/torrents && \
	chown -R www-data:www-data /opt/www/rutorrent/share/settings && \
	:
