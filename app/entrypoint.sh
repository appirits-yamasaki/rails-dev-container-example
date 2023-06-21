#!/bin/bash
set -xe
rm -f /app/tmp/pids/server.pid
exec "$@"
