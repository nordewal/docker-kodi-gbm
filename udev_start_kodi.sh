#!/bin/bash

mount /media
/usr/bin/sudo -u joschi /usr/local/bin/docker-compose -f /home/joschi/home-services/kodi/docker-compose.yaml up -d
