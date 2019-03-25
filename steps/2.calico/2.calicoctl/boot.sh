#!/bin/bash

set -e;
mkdir -p /etc/calico/
cp calicoctl.cfg /etc/calico/calicoctl.cfg

cp calicoctl /usr/bin

#cd /usr/bin
#wget https://github.com/projectcalico/calicoctl/releases/download/v3.4.0/calicoctl
#chmod +x calicoctl

echo "alias cc=\"calicoctl\"" >> ~/.bashrc
echo "alias ccnode=\"calicoctl get nodes -owide\"" >> ~/.bashrc
echo "alias ccstatus=\"calicoctl node status\"" >> ~/.bashrc

