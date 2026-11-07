#!/bin/sh
set -e
UUID="${UUID:-}"
WS_PATH="${WS_PATH:-}"
PORT="${PORT:-3000}"
if [ -z "$UUID" ]; then echo "UUID env var is required" >&2; exit 1; fi
if [ -z "$WS_PATH" ]; then echo "WS_PATH env var is required" >&2; exit 1; fi
mkdir -p /etc/xray
cat > /etc/xray/config.json <<JSON
{
  "log": { "loglevel": "warning" },
  "inbounds": [
    {
      "port": ${PORT},
      "protocol": "vless",
      "settings": { "clients": [ { "id": "${UUID}" } ] },
      "streamSettings": { "network": "ws", "wsSettings": { "path": "${WS_PATH}" } }
    }
  ],
  "outbounds": [ { "protocol": "freedom" } ]
}
JSON
exec /usr/local/bin/xray run -c /etc/xray/config.json
