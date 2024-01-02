# Shadowsocks Server with v2ray & kcptun support Dockerfile

FROM potzedd/shadowsocks-v2ray
MAINTAINER ="PotZedd <potzedd@gmail.com>"

ENV KCP_VER 20231012

RUN \
    apk add --no-cache --virtual .build-deps curl \
    && curl -fSL https://github.com/xtaci/kcptun/releases/download/v$KCP_VER/kcptun-linux-amd64-$KCP_VER.tar.gz | tar xz -C /usr/bin server_linux_amd64 \
    && apk del .build-deps \
    && apk add --no-cache supervisor

ADD supervisord.conf /etc/supervisord.conf

VOLUME ["/etc/kcptun"]
ENTRYPOINT ["/usr/bin/supervisord", "-c"]
CMD ["/etc/supervisord.conf"]
