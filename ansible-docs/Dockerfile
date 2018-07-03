FROM debian
LABEL maintainer="joelnbarnham@gmail.com"

WORKDIR /build

RUN \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y update && \
    apt-get -y install --no-install-recommends \
        git \
        make \
        python \
        python-pip \
        python-sphinx \
        python-yaml \
    && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    :

# The version of ansible to checkout from git
ARG ANSIBLE_VERSION=master

RUN \
    git clone https://github.com/ansible/ansible && \
    cd ansible/docs/docsite && \
    git checkout "${ANSIBLE_VERSION}" && \
    make all && \
    :

WORKDIR /build/ansible/docs/docsite/_build/html
EXPOSE 8000
CMD python -m SimpleHTTPServer
