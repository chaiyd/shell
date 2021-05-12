# kubernetes install

## containerd
- kubernetes is about to dockershim
- use containerd install kubernetes
- use ctr
  - kubernetes use namespaces k8s.io by defaults
  ```shell
  # ctr namespace ls
  # ctr -n k8s.io images check
  # ctr -n k8s.io images import app.tar
   ```

## kubernetes containerd kubeadm
- ipvs,containerd,calico
- Add the configuration to kubelet, otherwise unexpected errors will occur when kubeadm is reset
  ```shell
  Environment="KUBELET_KUBEADM_ARGS=--container-runtime=remote --runtime-request-timeout=15m --container-runtime-endpoint=unix:///run/containerd/containerd.sock --image-service-endpoint=unix:///run/containerd/containerd.sock"
  ```

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
