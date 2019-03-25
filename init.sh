#!/bin/bash

systemctl stop firewalld && systemctl disable firewalld
setenforce 0

swapoff -a && cat >> /etc/sysctl.conf << EOF 
vm.swappiness=0
EOF

# vi /etc/selinux/config 
# # SELINUX=disabled

cat >> /etc/sysctl.conf<< EOF
net.ipv4.ip_forward= 1
net.bridge.bridge-nf-call-ip6tables= 1
net.bridge.bridge-nf-call-iptables= 1
EOF

sysctl -p

systemctl daemon-reload
systemctl restart docker

yum install -y src/*

cp -f cfg/10-kubeadm.conf /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

systemctl enable kubelet && systemctl start kubelet

echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> /etc/bash_profile
echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> /etc/bashrc
echo "export KUBECONFIG=/etc/kubernetes/admin.conf"

echo "alias kubeall=\"kubectl get all --all-namespaces -owide\"" >> ~/.bashrc
echo "alias kubenode=\"kubectl get node -owide\"" >> ~/.bashrc
echo "alias kubelog=\"kubectl logs pod -n kube-system\"" >> ~/.bashrc
echo "10.10.12.203 harbor.kelu.com" >> /etc/hosts
echo "10.10.12.203 harbor.kelu.local" >> /etc/hosts

# kubeadm token create --print-join-command
# rm /usr/bin/crictl
