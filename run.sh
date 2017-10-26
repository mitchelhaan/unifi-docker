#!/bin/sh

# Ensure all the directories have been created (done at runtime for use with bind mounts)
mkdir -p /unifi/data /unifi/logs /run/unifi

java -jar $BASEDIR/lib/ace.jar start
