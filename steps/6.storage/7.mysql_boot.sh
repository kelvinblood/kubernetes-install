#!/bin/bash

helm install --name mysql -f mysql-config.yaml stable/mysql --namespace kelu
