#! /bin/sh

chown -R syncthing:users /config
chown -R syncthing:users /data

ls /config

if [ "$#" -eq "0" ]; then
	exec gosu syncthing env STNODEFAULTFOLDER=1 syncthing -no-browser -no-restart -gui-address="0.0.0.0:8384" -home="/config"
fi

exec gosu syncthing "$@"
