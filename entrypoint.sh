#!/usr/bin/env bash
cd /var/www/app

groupmod -g ${PGID} daker
usermod -u ${PUID} -g daker -G docker_env daker
usermod -p "*" daker
mkdir -p /home/daker/.docker-workspace
chown -R daker:daker /home/daker/.docker-workspace

exec /sbin/setuser daker "$@"
