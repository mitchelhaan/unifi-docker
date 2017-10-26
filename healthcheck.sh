#!/bin/sh

set -e

HTTPS_PORT=$(java -jar $BASEDIR/lib/ace.jar info | grep "^unifi.https.port=" | cut -d'=' -f2)

curl -kILs --fail https://localhost:${HTTPS_PORT}
