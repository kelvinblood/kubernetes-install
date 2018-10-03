#!/bin/bash

if [ `id -u` -ne 0 ];then
   echo " [NOTE] root permit is needed!"
   exit 1
fi

cdir="$(cd "$(dirname "$0")" && pwd)"

curl -sSL https://get.docker.com/ | sh
usermod -aG docker $USER
# daemon.json
mkdir -p /etc/docker
if [ -f "/etc/docker/daemon.json" ];then
    mv /etc/docker/daemon.json /etc/docker/daemon.json.bak.`date +%Y%m%d`
fi
cp ${cdir}/cfg/daemon.json /etc/docker/

# docker-compose
if [ -f "/usr/bin/docker-compose" ];then
    mv /usr/bin/docker-compose /usr/bin/docker-compose.bak.`date +%Y%m%d`
fi
chmod +x ${cdir}/cfg/docker-compose
cp ${cdir}/cfg/docker-compose /usr/bin/docker-compose

# reload and start docker engine
# systemctl daemon-reload
systemctl enable docker
systemctl start docker

