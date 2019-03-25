#!/bin/bash

set -e;

kubeadm reset;
rm -rf /var/etcd/calico-data/
rm -rf /etc/kubernetes/pki
rm -rf /var/lib/etcd
