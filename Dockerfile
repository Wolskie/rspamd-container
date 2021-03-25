FROM centos:latest
ENV container docker

LABEL maintainer="Mark Hahl <mark@hahl.id.au>" \
      org.label-schema.name="rspamd Docker Image" \
      org.label-schema.description="Docker image for rspamd." \
      org.label-schema.url="https://github.com/wolskie/rspamd-container" \
      org.label-schema.vcs-url="https://github.com/wolskie/rspamd-container" \
      org.label-schema.schema-version="1.0"

# Update system
RUN dnf install -y epel-release -y && \
    dnf upgrade -y && \
    dnf clean all && \
    rm -rf /var/cache/yum

# Install tools
RUN dnf install -y wget supervisor rsyslog

# Install rspamd repos
RUN wget https://rspamd.com/rpm/centos-8/rspamd-experimental.repo -O /etc/yum.repos.d/rspamd.repo && \
    rpm --import https://rspamd.com/rpm/gpg.key && \
    dnf update -y && \
    dnf install -y rspamd

COPY supervisord.conf /etc/supervisord.conf
COPY rsyslog.conf /etc/rsyslog.conf

CMD ["supervisord", "-c", "/etc/supervisord.conf"]

