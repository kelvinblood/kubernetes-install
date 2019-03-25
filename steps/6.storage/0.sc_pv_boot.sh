#!/bin/bash

kubectl apply -f 1.monocular-sc.yaml
kubectl apply -f 2.monocular-pv.yaml 
kubectl apply -f 3.jenkins-sc.yaml
kubectl apply -f 4.jenkins-pv.yaml 
kubectl apply -f 5.mysql-sc.yaml 
kubectl apply -f 6.mysql-pv.yaml 
kubectl apply -f 8.redis-sc.yaml 
kubectl apply -f 9.redis-pv.yaml
