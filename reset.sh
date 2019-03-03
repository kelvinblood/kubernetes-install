#!/bin/bash

set -e;

kubeadm reset;
rm -rf /var/etcd/calico-data/
