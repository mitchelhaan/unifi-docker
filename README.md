# unifi-docker

UniFi Controller docker image based on Alpine Linux

The built image size is under 500MB.

## Building

```
docker build https://github.com/mitchelhaan/unifi-docker.git#5.6.x -t mitchelhaan/unifi-docker:latest
```

## Running

[UniFi port reference](https://help.ubnt.com/hc/en-us/articles/218506997-UniFi-Ports-Used)

```
docker run -d \
 -p 8080:8080 \
 -p 8443:8443 \
 -p 8880:8880 \
 -p 8843:8843 \
 -p 6789:6789 \
 -p 3478:3478/udp \
 -p 5656-5699:5656-5699/udp \
 -p 10001:10001/udp \
 -v unifi:/unifi \
 --tmpfs /run \
 --name unifi-controller \
 mitchelhaan/unifi-docker:latest
```

## Credits

https://github.com/jacobalberty/unifi-docker

https://aur.archlinux.org/packages/unifi/
