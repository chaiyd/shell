#!/usr/bin/env sh

set -euo pipefail

version=1.18.0
local_ip=192.168.10.10

echo "##########################关闭防火墙，swap，selinux##########################"
# 关闭防火墙，swap，selinux
systemctl stop firewalld
systemctl disable firewalld

swapoff -a && sed -i 's/.*swap.*/#&/' /etc/fstab
setenforce 0 && sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

##开启转发
cat <<EOF >> /etc/sysctl.conf
net.ipv4.ip_forward = 1
net.ipv4.tcp_max_tw_buckets = 5000
net.ipv4.tcp_syncookies = 1
net.ipv4.tcp_max_syn_backlog = 1024
net.ipv4.tcp_synack_retries = 2
EOF

cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.tcp_max_syn_backlog = 8096
kernel.pid_max = 65535
net.netfilter.nf_conntrack_max = 10240
vm.swappiness = 0
EOF
sysctl --system

echo "#################################安装docker##########################################"
# step 1: 安装必要的一些系统工具
yum install -y yum-utils device-mapper-persistent-data lvm2
# Step 2: 添加软件源信息
yum-config-manager --add-repo https://mirrors.aliyun.com/docker-ce/linux/centos/docker-ce.repo
# Step 3: 更新并安装Docker-CE
yum makecache fast
yum -y install docker-ce
# Step 4: 开启Docker服务
systemctl start docker
systemctl enable docker

echo "#################################安装kubelet,kubeadm,kubectl##########################"

cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://mirrors.aliyun.com/kubernetes/yum/repos/kubernetes-el7-x86_64/
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://mirrors.aliyun.com/kubernetes/yum/doc/yum-key.gpg https://mirrors.aliyun.com/kubernetes/yum/doc/rpm-package-key.gpg
EOF
setenforce 0
#sudo yum install -y kubelet kubeadm kubectl --disableexcludes=kubernetes
yum install -y kubelet-$version kubeadm-$version kubectl-$version
#systemctl enable kubelet && systemctl start kubelet
systemctl enable --now kubelet

echo "#########################################拉取k8s镜像####################################"

sh -x ./k8s-images.sh $version

echo "#######################################初始化kubernetes#################################"
kubeadm init \
--apiserver-advertise-address=$local_ip \
#--image-repository registry.aliyuncs.com/google_containers \
--kubernetes-version $version \
--pod-network-cidr=10.244.0.0/16

mkdir -p $HOME/.kube
cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
chown $(id -u):$(id -g) $HOME/.kube/config


kubectl apply -f ./kube-flannel.yml
