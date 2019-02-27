#!/usr/bin/env bash

rm etcd.tgz
tar czvf etcd.tgz *

echo "wget http://__ETCD_REPLACE_IP_1__:39999/etcd.tgz"


python -m SimpleHTTPServer 39999

