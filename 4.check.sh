#!/usr/bin/env bash

etcdctl \
  --ca-file=/app/allblue/etcd/ssl/ca.pem \
  --cert-file=/app/allblue/etcd/ssl/peer.pem \
  --key-file=/app/allblue/etcd/ssl/peer-key.pem \
  --endpoints=https://10.19.0.70:2379,https://10.19.0.71:2379,https://10.19.0.72:2379  \
  cluster-health
