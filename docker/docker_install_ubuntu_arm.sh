#!/usr/bin/env sh


#########适用于ubuntu 18.04 arm64
#  GitHub：  https://github.com/chaiyd/shell

#关闭防火墙
sudo ufw disable
sudo systemctl disable ufw

#关闭selinux
sudo setenforce 0 && sed -i "s/SELINUX=enforcing/SELINUX=disabled/g" /etc/selinux/config

#更改apt源为阿里源
sudo sed -i s/ports.ubuntu.com/mirrors.aliyun.com/g /etc/apt/sources.list

sudo apt update -y
# step 1: 安装必要的一些系统工具
sudo apt -y install apt-transport-https ca-certificates curl software-properties-common
# step 2: 安装GPG证书
curl -fsSL https://mirrors.aliyun.com/docker-ce/linux/ubuntu/gpg | sudo apt-key add -
# Step 3: 写入软件源信息
sudo add-apt-repository "deb [arch=arm64] https://mirrors.aliyun.com/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
# Step 4: 更新并安装Docker-CE
sudo apt -y update
sudo apt -y install docker-ce
# Step 5: 更新并安装docker-compose
sudo apt -y install docker-compose

# 启动docker，并增加开机自启
systemctl start docker
systemctl enable docker
# 安装指定版本的Docker-CE:
# Step 1: 查找Docker-CE的版本:
# apt-cache madison docker-ce
#   docker-ce | 17.03.1~ce-0~ubuntu-xenial | https://mirrors.aliyun.com/docker-ce/linux/ubuntu xenial/stable amd64 Packages
#   docker-ce | 17.03.0~ce-0~ubuntu-xenial | https://mirrors.aliyun.com/docker-ce/linux/ubuntu xenial/stable amd64 Packages
# Step 2: 安装指定版本的Docker-CE: (VERSION例如上面的17.03.1~ce-0~ubuntu-xenial)
# sudo apt -y install docker-ce=[VERSION]
