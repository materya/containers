#!/bin/sh

set -e

XDEBUG_MAJOR_VERSION=$(echo $XDEBUG_VERSION | cut -d'.' -f1)

XDEBUG_INI_DEFAULT=/opt/docker/xdebug${XDEBUG_MAJOR_VERSION}.ini
XDEBUG_INI_CUSTOM=${XDEBUG_INI}.custom
XDEBUG_INI=/usr/local/etc/php/conf.d/xdebug.ini

: "${XDEBUG_IDE:=VSCODE}"
: "${XDEBUG_PORT:=9003}"

if [ -f $XDEBUG_INI_CUSTOM ]; then
  cp $XDEBUG_INI_CUSTOM $XDEBUG_INI
else
  cp $XDEBUG_INI_DEFAULT $XDEBUG_INI
  sed -i "s/xdebug.idekey=.*/xdebug.idekey=${XDEBUG_IDE}/" ${XDEBUG_INI}
  sed -i "s/xdebug.remote_port=.*/xdebug.remote_port=${XDEBUG_PORT}/" ${XDEBUG_INI}
  sed -i "s/xdebug.client_port=.*/xdebug.client_port=${XDEBUG_PORT}/" ${XDEBUG_INI}
fi

# Then, drop privileges and run your application
exec su-exec ${DOCKER_USER} "$@"
