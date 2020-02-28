FROM alpine:latest as builder

RUN    apk update \
    && apk add --no-cache  \
           alpine-sdk \
           coreutils \
           cmake \
    && adduser -G abuild -g "Alpine Package Builder" -s /bin/ash -D builder \
    && echo "builder ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

COPY APKBUILD /home/builder/

USER builder
RUN    cd /home/builder \
    && abuild-keygen -a -i -n \
    && abuild -r

FROM alpine:latest

LABEL Description="Dockerized MiKTeX, Alpine Linux latest" \
      Vendor="Christian Schenk" \
      Version="2.9.7300"

COPY --from=builder /home/build/packages/builder/x86_64/miktex-*.apk .

RUN    apk update \
    && apk add --no-cache \
           ca-certificates \
           ghostscript \
           gnupg \
           gosu \
           make \
           perl \
           curl \
    && apk add --no-cache --allow-untrusted miktex-*.apk \
    && rm -rf miktex-*.apk \
    && addgroup miktex \
    && adduser -s /bin/bash -D miktex

USER miktex
WORKDIR /home/miktex
RUN    miktexsetup finish \
    && initexmf --admin --set-config-value=[MPM]AutoInstall=1 \
    && mpm --admin --update-db \
    && mpm --admin \
           --install amsfonts \
           --install biber-linux-x86_64 \
    && initexmf --admin --update-fndb

#ENV MIKTEX_USERCONFIG=/home/miktex/.miktex/texmfs/config \
#    MIKTEX_USERDATA=/home/miktex/.miktex/texmfs/data \
#    MIKTEX_USERINSTALL=/home/miktex/.miktex/texmfs/install

ENTRYPOINT ["bash"]
