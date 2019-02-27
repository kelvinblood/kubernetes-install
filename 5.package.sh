#!/usr/bin/env bash

rm etcd.tgz
tar czvf etcd.tgz *

echo "wget http://xxx:39999/etcd.tgz"

python -m SimpleHTTPServer 39999

