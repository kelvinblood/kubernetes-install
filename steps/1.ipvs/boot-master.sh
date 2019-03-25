#!/bin/bash

# 每台机器都要运行modprobe

rm *.yaml;
kubectl get configmap kube-proxy -n kube-system -oyaml >kube-proxy-configmap.yaml
sed -e '/mode:/s/""/"ipvs"/g' kube-proxy-configmap.yaml  >kube-proxy-configmap-ipvs.yaml
kubectl replace -f kube-proxy-configmap-ipvs.yaml 
kubectl get pod  -n kube-system|grep kube-proxy|awk '{print "kubectl delete po "$1" -n kube-system"}'|sh

# https://segmentfault.com/a/1190000015104653
# https://blog.frognew.com/2018/10/kubernetes-kube-proxy-enable-ipvs.html#%E5%8F%82%E8%80%83

# kubectl logs kube-proxy -n kube-system
# ipvsadm -ln

