# unifi-docker

UniFi Controller docker image based on Alpine Linux

## Building

```
$ docker build https://github.com/mitchelhaan/unifi-docker.git#5.6.29 -t mitchelhaan/unifi-docker:latest
```

## Running

```
$ docker run -d --network host -v unifi:/unifi --tmpfs /run --name unifi-controller mitchelhaan/unifi-docker:latest
```

## Credits

https://github.com/jacobalberty/unifi-docker
https://aur.archlinux.org/packages/unifi/
