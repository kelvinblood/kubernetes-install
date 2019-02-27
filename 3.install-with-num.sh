#!/usr/bin/env bash

set -e

rm -rf /app/kelu/etcd /app/kelu/etcddata
mkdir -p /app/kelu/etcddata /app/kelu/etcd 

cp etcd.conf /app/kelu/etcd 
cp -R ssl /app/kelu/etcd

if [ ! -e etcd-v3.1.18-linux-amd64.tar.gz ]; then
  wget https://github.com/coreos/etcd/releases/download/v3.1.18/etcd-v3.1.18-linux-amd64.tar.gz
fi

tar -zxvf etcd-v3.1.18-linux-amd64.tar.gz > /dev/null

mv etcd-v3.1.18-linux-amd64 /app/kelu/etcd

rm -rf /usr/bin/etcd /usr/bin/etcdctl /etc/systemd/system/etcd.service
ln -s /app/kelu/etcd/etcd-v3.1.18-linux-amd64/etcd /usr/bin/etcd
ln -s /app/kelu/etcd/etcd-v3.1.18-linux-amd64/etcdctl /usr/bin/etcdctl

cp -f cfg/etcd.service.$1 /etc/systemd/system/etcd.service

systemctl daemon-reload
systemctl enable etcd
#systemctl start etcd
#systemctl status etcd
