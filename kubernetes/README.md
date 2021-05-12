# kubernetes install

## containerd
- kubernetes is about to dockershim
- use containerd install kubernetes
- use ctr
  - kubernetes use namespaces k8s.io by defaults
  ```shell
  ctr namespace ls
  ctr -n k8s.io images check
  ctr -n k8s.io images import app.tar
   ```

## kubernetes containerd kubeadm
- ipvs,containerd,calico
- Add the configuration to kubelet, otherwise unexpected errors will occur when kubeadm is reset
  ```shell
  #/usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf 
  #Environment="KUBELET_KUBEADM_ARGS=--container-runtime=remote --runtime-request-timeout=15m --container-runtime-endpoint=unix:///run/containerd/containerd.sock --image-service-endpoint=unix:///run/containerd/containerd.sock"
  sed -i '/Service/aEnvironment="KUBELET_KUBEADM_ARGS=--container-runtime=remote --runtime-request-timeout=15m --container-runtime-endpoint=unix:///run/containerd/containerd.sock --image-service-endpoint=unix:///run/containerd/containerd.sock" ' /usr/lib/systemd/system/kubelet.service.d/10-kubeadm.conf
  ```

## kubeadm init
- init
  - kubeadm init --config kubeadm-init-config.yaml --upload-certs
  ```shell
  ---
  # setting ipvs
  apiVersion: kubeproxy.config.k8s.io/v1alpha1
  kind: KubeProxyConfiguration
  mode: ipvs
  # setting cgroupDriver systemd
  ---
  apiVersion: kubelet.config.k8s.io/v1beta1
  kind: KubeletConfiguration
  cgroupDriver: systemd
  ```
## Creating Highly Available clusters with kubeadm
- kubeadm init --config kubeadm-config.yaml --upload-certs
- official docs
  - [Bootstrapping clusters with kubeadm](https://kubernetes.io/docs/setup/production-environment/tools/kubeadm/high-availability/)
  ```shell
  sudo kubeadm join 192.168.0.200:6443 --token 9vr73a.a8uxyaju799qwdjv \
  --discovery-token-ca-cert-hash sha256:7c2e69131a36ae2a042a339b33381c6d0d43887e2de83720eff5359e26aec866 \
  --control-plane \
  --certificate-key f8902e114ef118304e561c3ecd4d0b543adc226b7a07f675f56564185ffe0c07
  ```
  - The --control-plane flag tells kubeadm join to create a new control plane.
  - The --certificate-key ... will cause the control plane certificates to be downloaded from the kubeadm-certs Secret in the cluster and be decrypted using the given key

## calico
- View Official docs
- If you are using pod CIDR 192.168.0.0/16, skip to the next step. If you are using a different pod CIDR with kubeadm, no changes are required - Calico will automatically detect the CIDR based on the running configuration. For other platforms, make sure you uncomment the `CALICO_IPV4POOL_CIDR` variable in the manifest and set it to the same value as your chosen pod CIDR.
```shell
# https://docs.projectcalico.org/getting-started/kubernetes/self-managed-onprem/onpremises
# Install Calico with Kubernetes API datastore, 50 nodes or less
# curl https://docs.projectcalico.org/manifests/calico.yaml -O
# Install Calico with Kubernetes API datastore, more than 50 nodes
# curl https://docs.projectcalico.org/manifests/calico-typha.yaml -o calico.yaml
# Download the Calico networking manifest for etcd.
# curl https://docs.projectcalico.org/manifests/calico-etcd.yaml -o calico.yaml
```

## metrics
- officaial docs
  - [kube-state-metrics](https://github.com/kubernetes/kube-state-metrics.git)
  - [metrics-server](https://github.com/kubernetes-sigs/metrics-server.git)
  ```
  kubectl apply -f https://github.com/kubernetes-sigs/metrics-server/releases/latest/download/components.yaml
  ```
