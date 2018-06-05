#!/usr/bin/env bash

groupmod -g ${PGID} daker
usermod -u ${PUID} daker
usermod -p "*" daker
mkdir -p /home/daker/.docker-workspace
chown -R daker:daker /home/daker/.docker-workspace

exec /sbin/setuser daker "$@"
