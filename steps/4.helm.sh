#!/usr/bin/env bash

set -e

cd /tmp

if [ ! -f helm-v2.9.1-linux-amd64.tar.gz ]; then
  wget https://storage.googleapis.com/kubernetes-helm/helm-v2.9.1-linux-amd64.tar.gz
fi

tar zxvf helm-v2.9.1-linux-amd64.tar.gz
mv -f linux-amd64/helm /usr/bin/
rm -rf linux-amd64

kubectl create serviceaccount --namespace kube-system tiller
kubectl create clusterrolebinding tiller-cluster-rule --clusterrole=cluster-admin --serviceaccount=kube-system:tiller

helm init -i kelvinblood/tiller:v2.9.0 --stable-repo-url https://burdenbear.github.io/kube-charts-mirror/

kubectl patch deploy --namespace kube-system tiller-deploy -p '{"spec":{"template":{"spec":{"serviceAccount":"tiller"}}}}'

cd ~ && helm completion bash > .helmrc && echo "source .helmrc" >> .bashrc
