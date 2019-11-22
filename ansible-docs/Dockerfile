FROM debian:stable
LABEL maintainer="joelnbarnham@gmail.com"

WORKDIR /build

RUN \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y update && \
    apt-get -y install --no-install-recommends \
        git \
        make \
        python3 \
        python3-pip \
        python3-sphinx \
        python3-straight.plugin \
        python3-yaml \
    && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    :

RUN \
    pip3 install --no-cache-dir sphinx-notfound-page && \
    :

# The version of ansible to checkout from git
ARG ANSIBLE_VERSION=devel

RUN \
    git clone https://github.com/ansible/ansible && \
    cd ansible/docs/docsite && \
    git checkout "${ANSIBLE_VERSION}" && \
    make htmldocs && \
    :


FROM httpd:alpine
LABEL maintainer="joelnbarnham@gmail.com"

COPY --from=0 /build/ansible/docs/docsite/_build/html/ /usr/local/apache2/htdocs/
