#!/bin/sh
set -e

# first arg is `-f` or `--some-option`
if [ "${1#-}" != "$1" ]; then
	set -- haproxy "$@"
fi

if [ "$1" = 'haproxy' ]; then
	shift # "haproxy"
	# if the user wants "haproxy", let's add a couple useful flags
	#   -W  -- "master-worker mode" (similar to the old "haproxy-systemd-wrapper"; allows for reload via "SIGUSR2")
	#   -db -- disables background mode
	set -- haproxy -W -db "$@"
fi

echo "Waiting for FastApi..."
until curl -I http://fastapi:5000/health 2>/dev/null | head -n 1 | cut -d " " -f2; do
  echo "FastApi , waiting..."
  sleep 2
done
echo "FastApi is ready"

exec "$@"
