# docker-kodi-gbm

from archlinux
maintainer nordewal "nordewal@gmail.com"

# Update & install yaourt
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm kodi-gbm
#    pacman --noconfirm -Rns $(pacman -Qtdq)

# enable webserver by default
ADD advancedsettings.xml /root/.kodi/userdata/advancedsettings.xml

VOLUME /root/.kodi

EXPOSE 8080/tcp 9777/udp 9090/tcp
CMD ["/usr/sbin/kodi"]
