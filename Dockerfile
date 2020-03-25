FROM alpine:latest

RUN apk update \
 && apk upgrade \
 && apk add --no-cache \
        ca-certificates \
 && update-ca-certificates \
 
 # Install postfix
 && apk add --no-cache \
    rspamd rspamd-controller rspamd-proxy ca-certificates supervisor \
 && (rm "/tmp/"* 2>/dev/null || true) && (rm -rf /var/cache/apk/* 2>/dev/null || true)

COPY supervisord.conf /etc/supervisord.conf
COPY rsyslog.conf /etc/rsyslog.conf

CMD ["supervisord", "-c", "/etc/supervisord.conf"]
