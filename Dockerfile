FROM alpine:latest
EXPOSE 53 53/udp 67/udp 80 443
ENV TZ "Europe/Berlin"
ENV WEBPASSWORD password
ENV REV_SERVER true
ENV REV_SERVER_TARGET 10.2.3.1
ENV REV_SERVER_DOMAIN local.domain
ENV REV_SERVER_CIDR 10.2.3.4/24
ENV DNSSEC true
ENV DNS1 127.0.0.1#5335
ENV DNS2 127.0.0.1#5335
RUN apk --no-cache update && apk upgrade \
        && apk --no-cache add bash git tzdata dialog newt procps dhcpcd openrc newt ncurses curl \
        && apk --no-cache add bind-tools nmap-ncat psmisc sudo unzip wget libidn nettle libcap \
        && apk --no-cache add openresolv iproute2-ss lighttpd lighttpd-mod_auth fcgi php8 php8-cgi \
        && apk --no-cache add php8-sqlite3 php8-session php8-openssl php8-json php8-fileinfo unbound \
        && apk --no-cache add php8-phar php8-intl udev-init-scripts-openrc busybox-initscripts \
        && mkdir -p /run/openrc \
        && touch /run/openrc/softlevel \
        && rc-update add crond default \
        && rc-update add unbound default \
        && rc-update add lighttpd default \
        && openrc default \
        && git clone https://gitlab.com/yvelon/pi-hole \
        && mkdir -p /etc/pihole
#        && sed -i 's/::wait:\/sbin\/openrc default/::sysinit:\/sbin\/openrc default/g' /etc/inittab
COPY etc/ /etc/
WORKDIR /pi-hole
RUN bash "automated install/basic-install.sh" --unattended && echo "success" || echo "fail"
WORKDIR /root
RUN rm -Rf /pi-hole/
COPY root/ /root/
CMD ["/root/run-pihole"]