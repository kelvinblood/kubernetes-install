#!/bin/bash

kubectl apply -f heapster-rbac.yaml  
kubectl apply -f heapster.yaml  
kubectl apply -f kubernetes-dashboard-admin.rbac.yaml  
kubectl apply -f kubernetes-dashboard.yaml
kubectl apply -f test.yaml
