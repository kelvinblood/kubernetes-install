#!/usr/bin/env bash

sed -i "s/__ETCD_REPLACE_IP_1__/g" generateCA.sh
sed -i "s/__ETCD_REPLACE_IP_2__/g" generateCA.sh
sed -i "s/__ETCD_REPLACE_IP_3__/g" generateCA.sh

sed -i "s/__ETCD_REPLACE_IP_1__/g" check.sh
sed -i "s/__ETCD_REPLACE_IP_2__/g" check.sh
sed -i "s/__ETCD_REPLACE_IP_3__/g" check.sh

cd cfg

sed -i "s/__ETCD_REPLACE_IP_1__/g" `ls`
sed -i "s/__ETCD_REPLACE_IP_2__/g" `ls`
sed -i "s/__ETCD_REPLACE_IP_3__/g" `ls`



