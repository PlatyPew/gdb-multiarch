FROM lopsided/archlinux:devel as build

RUN sed -i 's/#ParallelDownloads = 5/ParallelDownloads = 8/g' /etc/pacman.conf && \
    pacman -Sy --noconfirm && \
    sed -i 's/# %wheel ALL=(ALL:ALL) NOPASSWD: ALL/%wheel ALL=(ALL:ALL) NOPASSWD: ALL/g' /etc/sudoers && \
    curl -fsSL https://blackarch.org/strap.sh | sh && \
    pacman -S yay --noconfirm && \
    groupadd users && groupadd wheel && \
    useradd -m -g users -G wheel -s /bin/bash builder

USER builder
WORKDIR /home/builder

RUN MAKEFLAGS="-j$(nproc)" yay -S --noconfirm gdb-multiarch && \
    rm -rf /home/builder/.cache && \
    yay -Rdd --noconfirm gdb-common && \
    tar -czvf gdb-multiarch.tgz $(find / -name "*gdb*" 2> /dev/null | grep -v gdbm | grep -v gdbus | grep -v pacman)

FROM scratch
COPY --from=build /home/builder/gdb-multiarch.tgz .
