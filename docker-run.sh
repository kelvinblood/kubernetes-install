#!/bin/bash

docker run -d --name etcd \
-p 2379:2379 \
-p 2380:2380 \
--volume=etcd-data:/etcd-data \
192.168.99.1:5000/quay.io/coreos/etcd \
/usr/local/bin/etcd \
--data-dir=/etcd-data --name node2 \
--initial-advertise-peer-urls http://192.168.99.101:2380 --listen-peer-urls http://0.0.0.0:2380 \
--advertise-client-urls http://192.168.99.101:2379 --listen-client-urls http://0.0.0.0:2379 \
--initial-cluster-state new \
--initial-cluster-token docker-etcd \
--initial-cluster node1=http://192.168.99.100:2380,node2=http://192.168.99.101:2380,node3=http://192.168.99.102:2380

WorkingDirectory=/app/kelu/etcddata/
EnvironmentFile=/app/kelu/etcd/etcd.conf
User=root
ExecStart=/usr/bin/etcd \
  --name node01  \
  --cert-file=/app/kelu/etcd/ssl/server.pem  \
  --key-file=/app/kelu/etcd/ssl/server-key.pem  \
  --peer-cert-file=/app/kelu/etcd/ssl/peer.pem  \
  --peer-key-file=/app/kelu/etcd/ssl/peer-key.pem  \
  --trusted-ca-file=/app/kelu/etcd/ssl/ca.pem  \
  --peer-trusted-ca-file=/app/kelu/etcd/ssl/ca.pem  \
  --initial-advertise-peer-urls https://47.96.79.77:2380  \
  --listen-peer-urls https://47.96.79.77:2380  \
  --listen-client-urls https://47.96.79.77:2379,http://127.0.0.1:2379  \
  --advertise-client-urls https://47.96.79.77:2379  \
  --initial-cluster-token etcd-cluster-0  \
  --initial-cluster node01=https://47.96.79.77:2380,node02=https://153.126.154.248:2380,node03=https://103.254.208.55:2380  \
  --heartbeat-interval=1000 \
  --election-timeout=5000 \
  --initial-cluster-state new  \
  --data-dir=/app/kelu/etcddata
Restart=on-failure
RestartSec=5
LimitNOFILE=65536

[Install]
WantedBy=multi-user.target
