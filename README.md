# unifi-docker

## Building

```
$ docker build https://github.com/mitchelhaan/unifi-docker.git
```

## Running

```
$ docker run -d --network host -v unifi:/unifi --tmpfs /run --restart always --name unifi_controller mitchelhaan/unifi-docker:5.5.24
```
