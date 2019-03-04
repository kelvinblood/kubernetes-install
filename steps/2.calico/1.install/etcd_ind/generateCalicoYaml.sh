#!/bin/bash

rm calico.yaml
ETCD_CERT=`cat /etc/etcd/ssl/etcd.pem | base64 | tr -d '\n'`
ETCD_KEY=`cat /etc/etcd/ssl/etcd-key.pem | base64 | tr -d '\n'`
ETCD_CA=`cat /etc/etcd/ssl/ca.pem | base64 | tr -d '\n'`
ETCD_ENDPOINTS="https://10.19.0.41:2379,https://10.19.0.42:2379,https://10.19.0.43:2379"

cp calico.yaml.example calico.yaml  

sed -i "s@.*etcd_endpoints:.*@\ \ etcd_endpoints:\ \"${ETCD_ENDPOINTS}\"@gi" calico.yaml

sed -i "s@.*etcd-cert:.*@\ \ etcd-cert:\ ${ETCD_CERT}@gi" calico.yaml
sed -i "s@.*etcd-key:.*@\ \ etcd-key:\ ${ETCD_KEY}@gi" calico.yaml
sed -i "s@.*etcd-ca:.*@\ \ etcd-ca:\ ${ETCD_CA}@gi" calico.yaml

sed -i 's@.*etcd_ca:.*@\ \ etcd_ca:\ "/calico-secrets/etcd-ca"@gi' calico.yaml
sed -i 's@.*etcd_cert:.*@\ \ etcd_cert:\ "/calico-secrets/etcd-cert"@gi' calico.yaml
sed -i 's@.*etcd_key:.*@\ \ etcd_key:\ "/calico-secrets/etcd-key"@gi' calico.yaml

# 注释掉 calico-node 部分(由 Systemd 接管)
# sed -i '123,219s@.*@#&@gi' calico.yaml
