#!/usr/bin/env sh

version=$1

url=registry.cn-hangzhou.aliyuncs.com/google_containers
images=(`kubeadm config images list --kubernetes-version=$version|awk -F '/' '{print $2}'`)
for imagename in ${images[@]} ; do
  docker pull $url/$imagename
  docker tag $url/$imagename k8s.gcr.io/$imagename
  docker rmi -f $url/$imagename
done

docker pull quay.io/coreos/flannel:v0.12.0-amd64
