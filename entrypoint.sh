#!/usr/bin/env bash

groupmod -g ${PGID} -o daker
usermod -u ${PUID} -o daker
mkdir -p /home/daker/.docker-workspace
chown -R daker:daker /home/daker/.docker-workspace

exec /sbin/setuser daker "$@"
