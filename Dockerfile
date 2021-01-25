FROM alpine:latest

LABEL maintainer="Mark Hahl <mark@hahl.id.au>" \
      org.label-schema.name="Rspamd Docker Image" \
      org.label-schema.description="Docker image for Rspamd, the fast, free and open-source spam filtering system." \
      org.label-schema.url="https://github.com/wolskie/rspamd-container" \
      org.label-schema.vcs-url="https://github.com/wolskie/rspamd-container" \
      org.label-schema.schema-version="1.0"


RUN apk update \
 && apk upgrade \
 && apk add --no-cache \
        ca-certificates \
 && update-ca-certificates \
 
 # Install postfix
 && apk add --no-cache \
    rspamd rspamd-controller rspamd-proxy ca-certificates \
 && (rm "/tmp/"* 2>/dev/null || true) && (rm -rf /var/cache/apk/* 2>/dev/null || true)

USER 1001

CMD ["/usr/sbin/rspamd", "-i", "-f" ]

