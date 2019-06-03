#!/bin/bash
set -e

: ${ETHERPAD_DB_TYPE:=mysql}
: ${ETHERPAD_DB_HOST:=mysql}
: ${ETHERPAD_DB_PORT:=3306}
: ${ETHERPAD_DB_USER:=root}
: ${ETHERPAD_DB_NAME:=etherpad}
: ${ETHERPAD_DB_CHARSET:=utf8mb4}
ETHERPAD_DB_NAME=$( echo $ETHERPAD_DB_NAME | sed 's/\./_/g' )

# ETHERPAD_DB_PASSWORD is mandatory in mysql container, so we're not offering
# any default. If we're linked to MySQL through legacy link, then we can try
# using the password from the env variable MYSQL_ENV_MYSQL_ROOT_PASSWORD
if [ "$ETHERPAD_DB_USER" = 'root' ]; then
	: ${ETHERPAD_DB_PASSWORD:=$MYSQL_ENV_MYSQL_ROOT_PASSWORD}
fi

if [ -n "$ETHERPAD_DB_PASSWORD_FILE" ]; then
	: ${ETHERPAD_DB_PASSWORD:=$(cat $ETHERPAD_DB_PASSWORD_FILE)}
fi

if [ -z "$ETHERPAD_DB_PASSWORD" ]; then
	echo >&2 'error: missing required ETHERPAD_DB_PASSWORD environment variable'
	echo >&2 '  Did you forget to -e ETHERPAD_DB_PASSWORD=... ?'
	echo >&2
	echo >&2 '  (Also of interest might be ETHERPAD_DB_PASSWORD_FILE, ETHERPAD_DB_USER and ETHERPAD_DB_NAME.)'
	exit 1
fi

: ${ETHERPAD_TITLE:=Etherpad}
: ${ETHERPAD_PORT:=9001}

# Check if database already exists
if [ "$ETHERPAD_DB_TYPE" == 'mysql' ]; then
	RESULT=`mysql -u${ETHERPAD_DB_USER} -p${ETHERPAD_DB_PASSWORD} --port=${ETHERPAD_DB_PORT} \
		-h${ETHERPAD_DB_HOST} --skip-column-names \
		-e "SHOW DATABASES LIKE '${ETHERPAD_DB_NAME}'"`

	if [ "$RESULT" != $ETHERPAD_DB_NAME ]; then
		# mysql database does not exist, create it
		echo "Creating database ${ETHERPAD_DB_NAME}"

		mysql -u${ETHERPAD_DB_USER} -p${ETHERPAD_DB_PASSWORD} -h${ETHERPAD_DB_HOST} --port=${ETHERPAD_DB_PORT} \
		      -e "create database ${ETHERPAD_DB_NAME}"
	fi
fi
if [ "$ETHERPAD_DB_TYPE" == 'postgres' ]; then
	export PGPASSWORD=${ETHERPAD_DB_PASSWORD}
	if psql -U ${ETHERPAD_DB_USER} -h ${ETHERPAD_DB_HOST} postgres -lqt | cut -d \| -f 1 | grep -qw ${ETHERPAD_DB_NAME}; then
		true
	else
		# postgresql database does not exist, create it
		echo "Creating database ${ETHERPAD_DB_NAME}"
		psql -U ${ETHERPAD_DB_USER} -h ${ETHERPAD_DB_HOST} postgres \
			-c "create database ${ETHERPAD_DB_NAME}"
	fi
fi

if [ ! -f APIKEY.txt ] && [ ! -z "${ETHERPAD_API_KEY}" ] ; then
    echo "Creating APIKEY.txt as ETHERPAD_API_KEY is defined";
    echo "${ETHERPAD_API_KEY}" > APIKEY.txt
fi

if [ ! -f settings.json ]; then

	cat <<- EOF > settings.json
	{
	  "title": "${ETHERPAD_TITLE}",
	  "ip": "0.0.0.0",
	  "port": "${ETHERPAD_PORT}",
	  "dbType" : "${ETHERPAD_DB_TYPE}",
	  "dbSettings" : {
			    "user"    : "${ETHERPAD_DB_USER}",
			    "host"    : "${ETHERPAD_DB_HOST}",
			    "port"    : "${ETHERPAD_DB_PORT}",
			    "password": "${ETHERPAD_DB_PASSWORD}",
			    "database": "${ETHERPAD_DB_NAME}",
			    "charset": "${ETHERPAD_DB_CHARSET}"
			  },
	EOF

	if [ -n "$ETHERPAD_ADMIN_PASSWORD" ]; then

		: ${ETHERPAD_ADMIN_USER:=admin}

		cat <<- EOF >> settings.json
		  "users": {
		    "${ETHERPAD_ADMIN_USER}": {
		      "password": "${ETHERPAD_ADMIN_PASSWORD}",
		      "is_admin": true
		    }
		  },
		EOF
	fi

	cat <<- EOF >> settings.json
	}
	EOF
fi

exec "$@"
