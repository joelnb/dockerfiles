FROM debian

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
        python3-venv \
        python3-yaml \
    && \
    apt-get -y autoremove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* && \
    :

# The version of cpython to checkout from git
ARG PYTHON_VERSION=master

RUN \
    git clone https://github.com/python/cpython && \
    cd cpython/Doc && \
    git checkout "${PYTHON_VERSION}" && \
    :

RUN \
    cd cpython/Doc && \
    make venv && \
    . ./venv/bin/activate && \
    make html && \
    :


FROM httpd:alpine
LABEL maintainer="joelnbarnham@gmail.com"

COPY --from=0 /build/cpython/Doc/build/html/ /usr/local/apache2/htdocs/
