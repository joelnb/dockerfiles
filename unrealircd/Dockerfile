FROM debian:11
LABEL maintainer="joelnbarnham@gmail.com"

ENV UNREAL_VERSION=6.0.3
ENV ANOPE_VERSION=2.0.6

RUN export DEBIAN_FRONTEND=noninteractive \
	&& apt-get update \
	&& apt-get upgrade -y \
	&& apt-get install -y \
		build-essential \
		cmake \
		file \
		gcc \
		gnupg \
		libcurl4-openssl-dev \
		libgcrypt20 \
		libgcrypt20-dev \
		libssl-dev \
		make \
		openssl \
		wget \
		zlib1g \
		zlib1g-dev \
	&& gpg --keyserver keyserver.ubuntu.com --recv-keys 0xA7A21B0A108FF4A9 \
	&& apt-get clean \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	;

RUN groupadd -r unreal \
	&& useradd -r -g unreal unreal \
	&& mkdir -p /home/unreal \
	&& chown unreal:unreal /home/unreal \
	;

USER unreal

RUN cd /tmp \
	&& gpg --keyserver keyserver.ubuntu.com --recv-keys 0xA7A21B0A108FF4A9 \
	&& bash -c 'wget "https://www.unrealircd.org/downloads/unrealircd-${UNREAL_VERSION}.tar.gz"' \
	&& bash -c 'wget "https://www.unrealircd.org/downloads/unrealircd-${UNREAL_VERSION}.tar.gz.asc"' \
	&& tar xvzf unrealircd-${UNREAL_VERSION}.tar.gz \
	&& gpg --verify unrealircd-${UNREAL_VERSION}.tar.gz.asc unrealircd-${UNREAL_VERSION}.tar.gz \
	&& cd unrealircd-${UNREAL_VERSION} \
	&& ./Config \
	&& make \
	&& make install \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	;

COPY unrealircd.conf /home/unreal/unrealircd/conf/
COPY config.cache /tmp/

USER root

RUN chown unreal /tmp/config.cache \
	&& chown unreal /home/unreal/unrealircd/conf/unrealircd.conf \
	;

USER unreal

RUN cd /tmp \
	&& wget "https://github.com/anope/anope/releases/download/${ANOPE_VERSION}/anope-${ANOPE_VERSION}-source.tar.gz" \
	&& tar xvzf anope-${ANOPE_VERSION}-source.tar.gz \
	&& cd anope-${ANOPE_VERSION}-source \
	&& mv /tmp/config.cache . \
	&& ./Config -quick \
	&& cd build \
	&& make \
	&& make install \
	&& rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* \
	;

CMD /home/unreal/unrealircd/unrealircd start
