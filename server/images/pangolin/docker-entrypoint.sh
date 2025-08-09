#!/bin/sh
set -e

envsubst </app/config/config.yml.tmpl >/app/config/config.yml
exec /usr/local/bin/docker-entrypoint.sh "$@"
