# Show values from repo
## Local
```bash
helm show values nfs-subdir-external-provisioner/nfs-subdir-external-provisioner
```
## Remote
```bash
helm show values nfs-subdir-external-provisioner --repo https://kubernetes-sigs.github.io/nfs-subdir-external-provisioner
helm show values prometheus-community/kube-prometheus-stack
```