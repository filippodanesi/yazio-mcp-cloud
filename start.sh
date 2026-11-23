#!/bin/sh
set -eu

: "${YAZIO_USERNAME:?Set YAZIO_USERNAME}"
: "${YAZIO_PASSWORD:?Set YAZIO_PASSWORD}"
: "${SECRET_PATH:?Set SECRET_PATH (a long random string)}"

if [ "${#SECRET_PATH}" -lt 24 ]; then
  echo "SECRET_PATH must be at least 24 characters" >&2
  exit 1
fi

export PORT="${PORT:-8080}"
YAZIO_BASIC="$(printf '%s:%s' "$YAZIO_USERNAME" "$YAZIO_PASSWORD" | base64 -w0)"
export YAZIO_BASIC

# Yazio MCP server, reachable only from inside the container
yazio-mcp-server --host 127.0.0.1 --port 8931 &

exec caddy run --config /etc/caddy/Caddyfile --adapter caddyfile
