#!/usr/bin/env bash

etcdctl \
  --ca-file=/app/kelu/etcd/ssl/ca.pem \
  --cert-file=/app/kelu/etcd/ssl/peer.pem \
  --key-file=/app/kelu/etcd/ssl/peer-key.pem \
  --endpoints=https://__ETCD_REPLACE_IP_1__:2379,https://__ETCD_REPLACE_IP_2__:2379,https://__ETCD_REPLACE_IP_3__:2379  \
  cluster-health
