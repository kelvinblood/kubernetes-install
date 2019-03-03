#!/bin/bash

# 每台机器都要运行modprobe

cat > /etc/sysconfig/modules/ipvs.modules <<EOF
#!/bin/bash
modprobe -- ip_vs
modprobe -- ip_vs_rr
modprobe -- ip_vs_wrr
modprobe -- ip_vs_sh
modprobe -- nf_conntrack_ipv4
EOF
chmod 755 /etc/sysconfig/modules/ipvs.modules && bash /etc/sysconfig/modules/ipvs.modules && lsmod | grep -e ip_vs -e nf_conntrack_ipv4

yum install -y ipset ipvsadm

rm *.yaml;
kubectl get configmap kube-proxy -n kube-system -oyaml >kube-proxy-configmap.yaml
sed -e '/mode:/s/""/"ipvs"/g' kube-proxy-configmap.yaml  >kube-proxy-configmap-ipvs.yaml
kubectl replace -f kube-proxy-configmap-ipvs.yaml 
kubectl get pod  -n kube-system|grep kube-proxy|awk '{print "kubectl delete po "$1" -n kube-system"}'|sh

# https://segmentfault.com/a/1190000015104653
# https://blog.frognew.com/2018/10/kubernetes-kube-proxy-enable-ipvs.html#%E5%8F%82%E8%80%83

# kubectl logs kube-proxy -n kube-system
# ipvsadm -ln

