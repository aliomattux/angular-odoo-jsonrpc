FROM ubuntu:18.04
LABEL author="Alfredo Rodríguez <wbison3@gmail.com>"

ENV LANG C.UTF-8

ENV TERM=xterm
ENV TZ=America/Mexico_City
ENV DEBIAN_FRONTEND=noninteractive

RUN apt update
RUN apt upgrade -y
RUN apt install -y --no-install-recommends \
        ca-certificates \
        apt-utils \
        wget \
        build-essential \
        ntp \
        git \
        sudo

RUN mkdir -p /root/Downloads
WORKDIR /root/Downloads
RUN wget https://nodejs.org/dist/v10.13.0/node-v10.13.0-linux-x64.tar.xz
RUN tar -C /usr/local --strip-components 1 -xJf node-v10.13.0-linux-x64.tar.xz
RUN useradd -ms /bin/bash dev
RUN usermod -aG sudo dev
RUN echo "dev ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/90-powerusers
RUN chmod 0440 /etc/sudoers.d/90-powerusers
COPY ./dev.entrypoint.sh /home/dev/entrypoint.sh
RUN chmod 700 /home/dev/entrypoint.sh
RUN mkdir /home/dev/angular7-odoo-jsonrpc
RUN chown -R dev:dev /home/dev
WORKDIR /home/dev/angular7-odoo-jsonrpc
EXPOSE 4200
USER dev
ENTRYPOINT [ "/home/dev/entrypoint.sh" ]
