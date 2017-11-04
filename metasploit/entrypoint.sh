#! /bin/sh

set -e

MSFDBPORT="${MSFDBPORT:-5432}"
MSFUSER="${MSFUSER:-postgres}"
MSFPASS="${MSFPASS:-postgres}"

export PGPASSWORD="${MSFPASS}"

if ! [ -z "$MSFDBHOST" ]; then
	if ! [ $(psql -h $MSFDBHOST -p $MSFDBPORT -U "$MSFUSER" -lqtA | grep "^msf|" | wc -l) == "1" ]; then
		psql -h $MSFDBHOST -p $MSFDBPORT -U "$MSFUSER" -c "CREATE DATABASE msf OWNER $MSFUSER;"
	fi

	cat > /usr/share/metasploit-framework/config/database.yml <<EOF
production:
  adapter: postgresql
  database: msf
  username: $MSFUSER
  password: $MSFPASS
  host: $MSFDBHOST
  port: $MSFDBPORT
  pool: 75
  timeout: 5
EOF
else
	exec /usr/share/metasploit-framework/msfconsole -n "$@"
fi

exec /usr/share/metasploit-framework/msfconsole "$@"
