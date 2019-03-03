#!/bin/bash

set -e;

kubeadm init --config cfg/config.yaml

kubectl taint nodes --all node-role.kubernetes.io/master-
