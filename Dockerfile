# docker-kodi-gbm

from archlinux/base
maintainer nordewal "nordewal@gmail.com"

# Update & install yaourt
RUN pacman -Syu --noconfirm && \
    pacman -S --noconfirm base-devel git && \
    chmod 640 /etc/sudoers && echo '%wheel ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers && chmod 440 /etc/sudoers && useradd -m -puz78tgZGviuvTF156 -G wheel yaourt && \
    sudo -u yaourt rm -rf /tmp/package-query && \
    sudo -u yaourt rm -rf /tmp/yaourt && \
    cd /tmp && \
    sudo -u yaourt git clone https://aur.archlinux.org/package-query.git && \
    cd /tmp/package-query && \
    yes | sudo -u yaourt makepkg -si && \
    cd .. && \
    sudo -u yaourt git clone https://aur.archlinux.org/yaourt.git && \
    cd /tmp/yaourt && \
    yes | sudo -u yaourt makepkg -si && \
    cd .. && \
    echo 'EXPORT=2' >> /etc/yaourtrc && \
    sed -i 's/git clone --mirror/git clone --depth 1 --mirror/' /usr/share/makepkg/source/git.sh && \
    sudo -u yaourt yaourt --version

# install kodi by using and modifying the kodi-git aur package
RUN cd /home/yaourt && \
    pacman --noconfirm -S libva-intel-driver && \
    sudo -u yaourt git clone https://aur.archlinux.org/kodi-git.git && \
    sudo -u yaourt sed -i 's/\(-DENABLE_EVENTCLIENTS=ON\)/\1 -DCORE_PLATFORM_NAME=gbm/' kodi-git/PKGBUILD && \
    sudo -u yaourt sed -i '/pkgver()/,+4d' kodi-git/PKGBUILD && \
    sudo -u yaourt yaourt -i --noconfirm -P kodi-git && \
    pacman --noconfirm -Rns $(pacman -Qtdq)

# enable webserver by default
ADD advancedsettings.xml /root/.kodi/userdata/advancedsettings.xml

VOLUME /root/.kodi

EXPOSE 8080/tcp 9777/udp 9090/tcp
CMD ["/usr/sbin/kodi"]
