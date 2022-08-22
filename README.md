# pihole_alpine

How to build:

docker build -t pihole_alpine:1.0 .

How to run:

docker run --name pihole_alpine -p 80:80 -p 53:53/udp --net <your network> --ip <ip of the docker image>  --privileged --cap-add=NET_ADMIN --restart=unless-stopped -e REV_SERVER_TARGET=<xxx> -e WEBPASSWORD=<yyy> -e REV_SERVER_CIDR=<zzz>/24 -e REV_SERVER_DOMAIN=<domain.lan> --hostname=pihole pihole_alpine:1.0

Parameters:

* TZ "Europe/Berlin"
* WEBPASSWORD password
* REV_SERVER true
* REV_SERVER_TARGET 10.2.3.1
* REV_SERVER_DOMAIN local.domain
* REV_SERVER_CIDR 10.2.3.4/24
* DNSSEC true
* DNS1 127.0.0.1#5335
* DNS2 127.0.0.1#5335

The parameters enclosed in < > are to be customized. As I want to give the docker image an IP address in the same network as my home lan (and not in 172.17....) I defined a network (see --net parameter).

Size:

From 345.8 MB (cbcrowe/pihole-unbound:latest image based on Debian) to 134.4 (my image, based on vanilla Alpine 3.16 plus https://gitlab.com/yvelon/pi-hole ) a whopping 211.4 MB less

Known bugs:

I haven't find out how to start pihole (my bad - I just started tinkering with Docker), hence in the script launched via CMD (run-pihole) has a "sleep infinity" at the end. If anyone knows how to improve it, please get in touch with me :)
