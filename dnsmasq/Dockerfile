FROM joelnb/dumb-init-alpine:3
LABEL maintainer="joelnbarnham@gmail.com"

ENV HOSTESS_VERSION=v0.2.0

RUN apk add --update \
		bash \
		ca-certificates \
		dnsmasq \
		drill \
		wget \
	&& update-ca-certificates \
	&& wget -O /usr/local/bin/hostess https://github.com/cbednarski/hostess/releases/download/${HOSTESS_VERSION}/hostess_linux_amd64 \
	&& chmod a+x /usr/local/bin/hostess \
	&& apk del \
		wget \
	&& rm -rf /var/cache/apk/* \
	&& mkdir -p /etc/dnsmasq.d \
	;

ENV HOSTESS_PATH="/etc/dnsmasq.hosts"

COPY ["dnsmasq.hosts", "dnsmasq.resolv.conf", "dnsmasq.conf", "/etc/"]
COPY ["entrypoint.sh", "/usr/bin/"]

EXPOSE 53 53/udp

ENTRYPOINT ["dumb-init", "--", "/usr/bin/entrypoint.sh"]
CMD ["dnsmasq"]
