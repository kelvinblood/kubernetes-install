#!/usr/bin/env bash
# 
# author: chongweiling@caih.com
#   date: 2018-01-23
# 
# update:
#   1) install binary from rpm package.
#
################################

if [ `id -u` -ne 0 ];then
   echo " [NOTE] root permit is needed!"
   exit 1
fi

cdir="$(cd "$(dirname "$0")" && pwd)"

# binary
wget https://download.docker.com/linux/centos/7/x86_64/stable/Packages/docker-ce-17.06.2.ce-1.el7.centos.x86_64.rpm
sudo yum install -y docker-ce-17.06.2.ce-1.el7.centos.x86_64.rpm

# daemon.json
mkdir -p /etc/docker
if [ -f "/etc/docker/daemon.json" ];then
    mv /etc/docker/daemon.json /etc/docker/daemon.json.bak.`date +%Y%m%d`
fi
sudo cp ${cdir}/cfg/daemon.json /etc/docker/

# docker.service
if [ -f "/usr/lib/systemd/system/docker.service" ];then
    mv /usr/lib/systemd/system/docker.service /usr/lib/systemd/system/docker.service.bak.`date +%Y%m%d`
fi
mkdir -p /usr/lib/systemd/system/ && sudo cp ${cdir}/cfg/docker.service /usr/lib/systemd/system/docker.service

# docker-compose
if [ -f "/usr/bin/docker-compose" ];then
    mv /usr/bin/docker-compose /usr/bin/docker-compose.bak.`date +%Y%m%d`
fi
chmod +x ${cdir}/cfg/docker-compose
sudo cp ${cdir}/cfg/docker-compose /usr/bin/docker-compose

rm -rf /etc/systemd/system/multi-user.target.wants/docker.service
ln -s /usr/lib/systemd/system/docker.service /etc/systemd/system/multi-user.target.wants/docker.service 

# reload and start docker engine
systemctl daemon-reload
systemctl restart docker

