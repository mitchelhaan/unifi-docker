# unifi-docker

UniFi Controller docker image based on Alpine Linux

## Building

```
$ docker build https://github.com/mitchelhaan/unifi-docker.git#5.5.24 -t mitchelhaan/unifi-docker:5.5.24
```

## Running

```
$ docker run -d --network host -v unifi:/unifi --tmpfs /run --name unifi-controller mitchelhaan/unifi-docker:5.5.24
```

## Credits

https://github.com/jacobalberty/unifi-docker
https://aur.archlinux.org/packages/unifi/
