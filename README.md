# unifi-docker

## Building

```
$ docker build https://github.com/mitchelhaan/unifi-docker.git
```

## Running

```
$ docker run -it --network=host -v unifi:/unifi --tmpfs /run <image/container>
```
