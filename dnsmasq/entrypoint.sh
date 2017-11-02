#! /bin/bash

# TODO: Work out why ENTRYPOINT seems to get ignored by 'docker exec'

case "$1" in
    dnsmasq)
        exec /usr/sbin/dnsmasq -h -k -8 - -q
        ;;
    hostess)
        hostess "$@"

        pkill -HUP dnsmasq
        ;;
esac

exec "$@"
