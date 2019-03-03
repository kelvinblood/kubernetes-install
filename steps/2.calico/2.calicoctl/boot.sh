#!/bin/bash

set -e;
cp calicoctl.cfg /etc/calico/calicoctl.cfg

cd /usr/bin
wget https://github.com/projectcalico/calicoctl/releases/download/v3.4.0/calicoctl
chmod +x calicoctl

