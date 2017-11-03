#! /bin/sh

set -e

DB_PORT="${DB_PORT:-5432}"
MSFUSER="${MSFUSER:-postgres}"
MSFPASS="${MSFPASS:-postgres}"

if ! [ -z "$DB_HOST" ]; then
	if ! [ $(psql -h $DB_HOST:$DB_PORT -p 5432 -U "$MSFUSER" "$MSFPASS" -lqtA | grep "^msf|" | wc -l) == "1" ]; then
		psql -h $DB_HOST:$DB_PORT -p 5432 -U "$MSFUSER" "$MSFPASS" -c "CREATE DATABASE msf OWNER $MSFUSER;"
	fi

	cat > /usr/share/metasploit-framework/config/database.yml <<EOF
production:
  adapter: postgresql
  database: msf
  username: $MSFUSER
  password: $MSFPASS
  host: $DB_HOST:$DB_PORT
  port: 5432
  pool: 75
  timeout: 5
EOF
else
	exec /usr/share/metasploit-framework/msfconsole -n "$@"
fi

exec /usr/share/metasploit-framework/msfconsole "$@"
