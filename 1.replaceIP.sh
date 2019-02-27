#!/usr/bin/env bash

sed -i "s/__ETCD_REPLACE_IP_1__/g" `ls -R`
sed -i "s/__ETCD_REPLACE_IP_2__/g" `ls -R`
sed -i "s/__ETCD_REPLACE_IP_3__/g" `ls -R`



