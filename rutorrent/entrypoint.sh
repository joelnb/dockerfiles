#! /bin/bash

if [ "$#" -eq 0 ]; then
	[ ! -f /opt/www/rutorrent/index.html ] && tar xzvf /opt/www/master.tar.gz -C /opt/www/rutorrent --strip-components 1
	chown -R www-data:www-data /opt/www/rutorrent/share/torrents
	chown -R www-data:www-data /opt/www/rutorrent/share/settings
	supervisord -c /etc/supervisor/supervisord.conf
else
	exec "$@"
fi
