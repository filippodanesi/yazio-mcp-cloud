FROM ghcr.io/yazio-community/yazio-mcp-server:1.4.2

USER root
RUN apk add --no-cache caddy
COPY Caddyfile /etc/caddy/Caddyfile
COPY start.sh /start.sh
RUN chmod 755 /start.sh

ENV XDG_DATA_HOME=/tmp XDG_CONFIG_HOME=/tmp
USER 10001

ENTRYPOINT ["/start.sh"]
