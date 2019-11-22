FROM joelnb/dumb-init-ubuntu:bionic
LABEL maintainer="joelnbarnham@gmail.com"

# This line:
#   git config --global http.https://gopkg.in.followRedirects true
# Is a result of this issue: https://github.com/niemeyer/gopkg/issues/50 and
# can be removed when this is solved.

ENV GOPATH=/go

RUN \
	export DEBIAN_FRONTEND=noninteractive && \
	apt-get update && \
	apt-get upgrade -y && \
	apt-get install -y \
		git \
		golang \
	&& \
	mkdir -p "$GOPATH/src/github.com/oragono" && \
	cd "$GOPATH/src/github.com/oragono" && \
	git clone https://github.com/oragono/oragono && \
	cd "$GOPATH/src/github.com/oragono/oragono" && \
	git config --global http.https://gopkg.in.followRedirects true && \
	git submodule init && \
	git submodule update && \
	go get github.com/gorilla/context && \
	go build oragono.go && \
	mv ./oragono /usr/local/bin && \
	mkdir -p /etc/oragono && \
	cp "$GOPATH/src/github.com/oragono/oragono/oragono.yaml" "/etc/oragono/ircd.yaml" && \
	cp "$GOPATH/src/github.com/oragono/oragono/oragono.motd" "/etc/oragono/oragono.motd" && \
	apt-get remove -y \
		git \
		golang \
	&& \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /go && \
	:

WORKDIR /etc/oragono
EXPOSE 6667 6668 6697 8080

COPY ircd.yaml /etc/oragono/

RUN \
	oragono --conf /etc/oragono/ircd.yaml mkcerts && \
	oragono --conf /etc/oragono/ircd.yaml initdb && \
	:

ENTRYPOINT ["dumb-init", "--", "oragono"]
CMD ["--conf", "/etc/oragono/ircd.yaml"]
