#!/bin/bash

set -e;

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

kubeadm init --config cfg/config.yaml

echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> /etc/bash_profile
echo "export KUBECONFIG=/etc/kubernetes/admin.conf" >> /etc/bashrc
export KUBECONFIG=/etc/kubernetes/admin.conf

echo "please echo export KUBECONFIG=/etc/kubernetes/admin.conf"
echo "then run bin/install_flannel bin/install_dashboard bin/install_helm"

yum install -y ipset ipvsadm

cat > /etc/sysconfig/modules/ipvs.modules <<EOF
#!/bin/bash
modprobe -- ip_vs
modprobe -- ip_vs_rr
modprobe -- ip_vs_wrr
modprobe -- ip_vs_sh
modprobe -- nf_conntrack_ipv4
EOF
chmod 755 /etc/sysconfig/modules/ipvs.modules && bash /etc/sysconfig/modules/ipvs.modules && lsmod | grep -e ip_vs -e nf_conntrack_ipv4

kubeadm init --config cfg/config.yaml

kubectl taint nodes --all node-role.kubernetes.io/master-
