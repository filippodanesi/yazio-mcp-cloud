FROM python:3.12-slim

# yazio-mcp-server is not published on PyPI: install it from a pinned GitHub commit
ARG YAZIO_MCP_REF=409326c7a484196b464764ab80cb52141bbfe41a

RUN apt-get update \
 && apt-get install -y --no-install-recommends caddy \
 && rm -rf /var/lib/apt/lists/* \
 && pip install --no-cache-dir "https://github.com/yazio-community/yazio-mcp-server/archive/${YAZIO_MCP_REF}.tar.gz" \
 && useradd -u 10001 -m app

COPY Caddyfile /etc/caddy/Caddyfile
COPY start.sh /start.sh
RUN chmod 755 /start.sh

ENV XDG_DATA_HOME=/tmp XDG_CONFIG_HOME=/tmp PYTHONUNBUFFERED=1
USER 10001

ENTRYPOINT ["/start.sh"]
