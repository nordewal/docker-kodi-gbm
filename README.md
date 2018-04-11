# docker-kodi-gbm

The idea of this container is to run Kodi on a X86 linux without X11. Kodi is compiled without X11 and will therefore directly use Linux DRM/DRI to output the Kodi "window". Intel VAAPI is used as hardware acceleration. For NVIDIA or ATI graphic cards you might need to install the corresponding `libva-*-driver` packages during build as well
During build the `advancedsettings.xml` file is injected to auto-start the Kodi built-in webserver.

## Download the container
The container can also be found on docker hub:


## Run
### Using docker-compose:
```
docker-compose up -d
```
### Using docker run:
To run the container, you need to map the corresponding input and output devices as well:
```
docker run -d --device="/dev/input" --device="/dev/snd" --device=/dev/dri --group-add video -v /etc/localtime:/etc/localtime:ro -p 8080:8080 -p 9777:9777/udp nordewal/kodi-gbm
```

## Build
To build the container, simply run:
```
docker build .
```
