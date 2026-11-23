FROM python:3.12-slim

RUN apt-get update \
 && apt-get install -y --no-install-recommends caddy \
 && rm -rf /var/lib/apt/lists/* \
 && pip install --no-cache-dir yazio-mcp-server \
 && useradd -u 10001 -m app

COPY Caddyfile /etc/caddy/Caddyfile
COPY start.sh /start.sh
RUN chmod 755 /start.sh

ENV XDG_DATA_HOME=/tmp XDG_CONFIG_HOME=/tmp
USER 10001

ENTRYPOINT ["/start.sh"]
