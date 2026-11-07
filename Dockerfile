# Multi-stage: official xray image has no shell, copy binary into Alpine
FROM ghcr.io/xtls/xray-core:latest AS xray
FROM alpine:latest
RUN apk add --no-cache ca-certificates
COPY --from=xray /usr/local/bin/xray /usr/local/bin/xray
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
EXPOSE 3000
ENTRYPOINT ["/entrypoint.sh"]
