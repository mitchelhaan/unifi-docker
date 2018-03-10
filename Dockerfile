FROM openjdk:8-jre-alpine

LABEL maintainer="Mitchel Haan <mitchel@mhstud.io>"
LABEL description="UniFi Controller container based on Alpine Linux"

RUN apk add --no-cache curl mongodb java-snappy libc6-compat tini

ARG UNIFI_VERSION=5.7.20
ARG UNIFI_SHA256=8e2202d835fb7d5f271016892147e749785bdc77490d76206a535425d59f48b5
ARG UNIFI_ZIP=UniFi.unix.zip

# Retrieve the installation file
RUN curl https://dl.ubnt.com/unifi/$UNIFI_VERSION/$UNIFI_ZIP -o /tmp/$UNIFI_ZIP && echo "$UNIFI_SHA256  /tmp/$UNIFI_ZIP" | sha256sum -c -
#COPY UniFi.unix.zip /tmp

RUN unzip /tmp/$UNIFI_ZIP -d /tmp && rm /tmp/$UNIFI_ZIP

# Move the installation into its proper place
ENV BASEDIR=/usr/lib/unifi
RUN install -dm755 $BASEDIR && mv /tmp/UniFi/* $BASEDIR && rmdir /tmp/UniFi
RUN ln -sf /usr/bin/mongod $BASEDIR/bin/mongod && ln -sf /run/unifi $BASEDIR/run
RUN ln -sf /unifi/data /unifi/logs $BASEDIR/

# Copy in the Docker helper scripts
COPY run.sh healthcheck.sh $BASEDIR/

EXPOSE 8080/tcp 8443/tcp 8880/tcp 8843/tcp 6789/tcp 3478/udp 5656-5699/udp 10001/udp
VOLUME /unifi

WORKDIR $BASEDIR

HEALTHCHECK CMD ./healthcheck.sh || exit 1

ENTRYPOINT ["/sbin/tini", "--", "./run.sh"]
