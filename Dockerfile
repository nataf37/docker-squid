FROM registry.access.redhat.com/ubi8/ubi:8.1

ENV SQUID_CACHE_DIR=/var/spool/squid \
    SQUID_LOG_DIR=/var/log/squid \
    SQUID_USER=proxy


RUN echo -e "[rhelosp-rhel-8.1-App]\nname=Red Hat Enterprise Linux \$releasever - \$basearch - ServerMirror\nbaseurl=http://download.engineering.redhat.com/released/rhel-6-7-8/rhel-\$releasever/RHEL-\$releasever/\$releasever.1.0/AppStream/\$basearch/os/\nenabled=1\ngpgcheck=0\npriority=30" > /etc/yum.repos.d/mirror-appstream.repo

run cat /etc/yum.repos.d/mirror-appstream.repo

RUN uname -a
RUN cat /etc/redhat-release

RUN dnf -y install squid
# RUN dnf -v install http://download-ipv4.eng.brq.redhat.com/released/RHEL-8/8.1.0/AppStream/x86_64/os/Packages/squid-4.4-8.module+el8.1.0+4044+36416a77.x86_64.rpm

COPY entrypoint.sh /sbin/entrypoint.sh
RUN chmod 755 /sbin/entrypoint.sh

EXPOSE 3128/tcp
ENTRYPOINT ["/sbin/entrypoint.sh"]
