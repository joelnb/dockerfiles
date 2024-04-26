FROM ubuntu:noble
LABEL maintainer="joelnbarnham@gmail.com"


RUN \
    export DEBIAN_FRONTEND=noninteractive && \
    apt-get -y update && \
    apt-get -y install --no-install-recommends \
        ca-certificates \
        curl \
        gnupg2 \
    && \
    curl -fsSL "https://keyserver.ubuntu.com/pks/lookup?op=get&search=0x93c4a3fd7bb9c367" | gpg --dearmor > /etc/apt/trusted.gpg.d/ansible.gpg && \
    echo "deb https://ppa.launchpadcontent.net/ansible/ansible/ubuntu jammy main" > /etc/apt/sources.list.d/ansible.list && \
    apt-get -y update && \
    apt-get -y install --no-install-recommends \
        ansible \
        ansible-lint \
        yamllint \
    && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    :
