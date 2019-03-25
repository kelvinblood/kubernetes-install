#!/bin/bash

set -e;

./install.sh
cd steps/1.ipvs
./boot-master.sh
cd ../2.calico/1.install/simple

#cd steps/2.calico/1.install/simple

kubectl apply -f etcd.yaml
kubectl apply -f calico.yaml
