#!/bin/bash

helm install --name redis -f redis-config.yaml stable/redis --namespace kelu
