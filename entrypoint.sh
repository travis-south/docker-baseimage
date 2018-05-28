#!/usr/bin/env bash
cd /var/www/app

groupmod -g ${PGID} daker
usermod -u ${PUID} -g daker -G docker_env daker
usermod -p "*" daker

exec /sbin/setuser daker "$@"
