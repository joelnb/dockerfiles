FROM kalilinux/kali-linux-docker
MAINTAINER Joel Noyce Barnham <joelnbarnham@gmail.com>

RUN \
	apt-get update && \
	apt-get -y upgrade && \
	apt-get -y install --no-install-recommends metasploit-framework && \
	apt-get -y autoremove && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
	:
