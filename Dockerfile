FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

# Instal·lació de paquets essencials
RUN apt update && apt install -y \
    xfce4 xfce4-goodies tightvncserver \
    wget curl openssh-server python3 python3-pip \
    dbus-x11 x11-xserver-utils sudo nano git software-properties-common \
    && apt clean

# Crear usuari docker amb permisos sudo
RUN useradd -m docker && echo "docker:docker" | chpasswd && adduser docker sudo

# Permetre sudo sense contrasenya
RUN echo "docker ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

# Preparar carpetes del servidor SSH
RUN mkdir -p /etc/ssh /var/run/sshd

# Instal·lar Visual Studio Code
RUN wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg \
    && install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/ \
    && sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list' \
    && apt update && apt install -y code \
    && rm microsoft.gpg

# Configuració del servidor VNC (com a root)
RUN mkdir -p /home/docker/.vnc
COPY scripts/startup.sh /home/docker/.vnc/xstartup
RUN chmod +x /home/docker/.vnc/xstartup
RUN chown -R docker:docker /home/docker/.vnc

# Passar a usuari normal
USER docker

# Contrasenya per al VNC
RUN echo "docker" | vncpasswd -f > /home/docker/.vnc/passwd && chmod 600 /home/docker/.vnc/passwd

# Exposar ports
EXPOSE 5901 22

# Iniciar VNC, generar claus SSH i arrencar SSH
CMD ["bash", "-c", "vncserver :1 && sudo ssh-keygen -A && sudo /usr/sbin/sshd -D"]
