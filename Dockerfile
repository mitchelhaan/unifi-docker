FROM openjdk:8-jre-alpine

LABEL maintainer="Mitchel Haan <mitchel@mhstud.io>"
LABEL description="UniFi Controller container based on Alpine Linux"

RUN apk add --no-cache curl mongodb tini

ARG UNIFI_VERSION=5.5.24
ARG UNIFI_SHA512=aaf8ce0679d7b9605e10c717efe8b676638891f15916e75003d897881ba6df5dcebb2818df769164efcb6e97265a2fdccaea34638a62e2fc6bb0072e12e78ba3
ENV UNIFI_ZIP=UniFi.unix.zip

# Retrieve the installation file
RUN curl https://dl.ubnt.com/unifi/$UNIFI_VERSION/$UNIFI_ZIP -o /tmp/$UNIFI_ZIP && echo "$UNIFI_SHA512  /tmp/$UNIFI_ZIP" | sha512sum -c -
#COPY UniFi.unix.zip /tmp

RUN unzip /tmp/$UNIFI_ZIP -d /tmp && rm /tmp/$UNIFI_ZIP

# Move the installation into its proper place
ENV BASEDIR=/usr/lib/unifi
RUN install -dm755 $BASEDIR && mv /tmp/UniFi/* $BASEDIR && rmdir /tmp/UniFi
RUN ln -sf /usr/bin/mongod $BASEDIR/bin/mongod && ln -sf /run/unifi $BASEDIR/run
RUN ln -sf /unifi/data /unifi/logs $BASEDIR/

# Copy in the Docker helper scripts
COPY run.sh healthcheck.sh $BASEDIR/

EXPOSE 6789/tcp 8080/tcp 8443/tcp 8880/tcp 8843/tcp 3478/udp 10001/udp
VOLUME /unifi

WORKDIR $BASEDIR

HEALTHCHECK CMD ./healthcheck.sh || exit 1

ENTRYPOINT ["/sbin/tini", "--", "./run.sh"]
