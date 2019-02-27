#!/usr/bin/env bash

set -e
cdir="$(cd "$(dirname "$0")" && pwd)"

rm -rf /var/lib/etcd /app/kelu/etcddata /etc/etcd/ssl
mkdir -p /var/lib/etcd
mkdir -p /app/kelu/etcddata
mkdir -p /etc/etcd/ssl

echo "下载 cfssl"
curl -o /usr/bin/cfssl https://pkg.cfssl.org/R1.2/cfssl_linux-amd64
curl -o /usr/bin/cfssljson https://pkg.cfssl.org/R1.2/cfssljson_linux-amd64
chmod +x /usr/bin/cfssl*

echo "CA 证书 配置: ca-config.json ca-csr.json"
cd /etc/etcd/ssl
cat >ca-config.json <<EOF
{
    "signing": {
        "default": {
            "expiry": "87600h"
        },
        "profiles": {
            "server": {
                "expiry": "87600h",
                "usages": [
                    "signing",
                    "key encipherment",
                    "server auth",
                    "client auth"
                ]
            },
            "client": {
                "expiry": "87600h",
                "usages": [
                    "signing",
                    "key encipherment",
                    "client auth"
                ]
            },
            "peer": {
                "expiry": "87600h",
                "usages": [
                    "signing",
                    "key encipherment",
                    "server auth",
                    "client auth"
                ]
            }
        }
    }
}
EOF

cat >ca-csr.json <<EOF
{
    "CN": "etcd",
    "key": {
        "algo": "rsa",
        "size": 2048
    }
}
EOF

echo "生成 CA 证书:  ca.csr ca-key.pem ca.pem"
cfssl gencert -initca ca-csr.json | cfssljson -bare ca -

echo "服务器端证书配置： config.json"
cat >config.json <<EOF
{
    "CN": "etcd-0",
    "hosts": [
        "localhost",
        "__ETCD_REPLACE_IP_1__",
        "__ETCD_REPLACE_IP_2__",
        "__ETCD_REPLACE_IP_3__"
    ],
    "key": {
        "algo": "ecdsa",
        "size": 256
    },
    "names": [
        {
            "C": "US",
            "L": "CA",
            "ST": "San Francisco"
        }
    ]
}
EOF
 
echo "生成服务器端证书 server.csr server.pem server-key.pem"
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=server config.json | cfssljson -bare server
echo "生成peer端证书 peer.csr peer.pem peer-key.pem"
cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=peer config.json | cfssljson -bare peer

rm -rf ${cdir}/ssl
cp -R /etc/etcd/ssl ${cdir}/
cp -R /etc/etcd/ssl /app/kelu/etcd
