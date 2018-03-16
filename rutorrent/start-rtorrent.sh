#!/bin/bash

set -x

# set rtorrent user and group id
RT_UID=${USR_ID:=1000}
RT_GID=${GRP_ID:=1000}

# update uids and gids
groupadd -g $RT_GID rtorrent
useradd -u $RT_UID -g $RT_GID -d /home/rtorrent -m -s /bin/bash rtorrent

touch /var/log/rtorrent.log
chown rtorrent:rtorrent /var/log/rtorrent.log

if [ ! -e /downloads/.rtorrent.rc ]; then
    cp /root/.rtorrent.rc /downloads/
fi
ln -s /downloads/.rtorrent.rc /home/rtorrent/

[ -f /downloads/.session/rtorrent.lock ] && rm /downloads/.session/rtorrent.lock

mkdir -p /downloads/{.session,.watch}
chown -R rtorrent:rtorrent /downloads/{.session,.watch}

su --login --command="TERM=xterm rtorrent" rtorrent
