# Usefull commands
## Create User
> [Certificate signing request](https://kubernetes.io/docs/reference/access-authn-authz/certificate-signing-requests/#normal-user)
```bash
openssl genrsa -out iodevopens_u.key 2048
openssl req -new -key iodevopens_u.key -subj "/CN=iodevopens_u/O=system:master" -out iodevopens_u.csr
# openssl x509 -req -in iodevopens_u.csr -CA /etc/kubernetes/pki/apiserver.crt -CAkey /etc/kubernetes/pki/apiserver.key -out iodevopens_u.crt
cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: iodevopens_u
spec:
  request: $(cat iodevopens_u.csr | base64 | tr -d "\n")
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400  # one day
  usages:
  - client auth
  groups:
  - system:authenticated
EOF
kubectl get csr
kubectl certificate approve iodevopens_u
kubectl get csr iodevopens_u -o yaml
kubectl get csr iodevopens_u -o jsonpath='{.status.certificate}'| base64 -d > iodevopens_u.crt
openssl x509 -in iodevopens_u.crt -text -noout
curl -k -v https://192.168.1.100:6443/api/v1/pods --key iodevopens_u.key --cert iodevopens_u.crt --cacert /etc/kubernetes/pki/ca.crt

# kubectl get pods --server 192.168.1.100:6443 --client-key iodevopens_u.key --client-certificate iodevopens_u.crt --certificate-authority /etc/kubernetes/pki/ca.crt

kubectl create role viewer --verb=get,list,watch --resource=pods,service
kubectl create rolebinding iodevopens_u-viewer --role viewer --user iodevopens_u
kubectl auth can-i --list --as iodevopens_u

kubectl config set-credentials iodevopens_u --client-certificate iodevopens_u.crt --client-key iodevopens_u.key --embed-certs=true
kubectl config set-context iodevopens_u@kubernetes --user iodevopens_u --cluster kubernetes
kubectl config use-context iodevopens_u@kubernetes

kubectl config set-context --current --namespace=mynamespace
```

```bash
kubectl proxy
curl -k http://localhost:8001 --silent
curl -k http://localhost:8001/apis --silent
kubectl api-resources --namespaced=false

kubectl port-forward services/mynginx 8080:80 --address 0.0.0.0
```

```bash
journalctl -u etcd-master
crictl --help
```

```bash
kubectl patch svc prometheus-community-grafana --namespace prometheus --type='json' -p '[{"op":"replace","path":"/spec/type","value":"NodePort"},{"op":"replace","path":"/spec/ports/0/nodePort","value":30080}]'

```

## Kubelet
```bash
curl -sk https://192.168.1.100:10250/pods --cert /etc/kubernetes/pki/apiserver-kubelet-client.crt --key /etc/kubernetes/pki/apiserver-kubelet-client.key --cacert /etc/kubernetes/pki/ca.crt | json_pp

# /var/lib/kubelet/config.yaml
## readOnlyPort: 10255
systemctl restart kubelet.service
curl -k http://192.168.1.100:10255/metrics

# Recommanded conf:
## authentication:
##   anonymous:
##     enabled: false
##   ...
## authorization:
##   mode: Webhook
##   ...
## readOnlyPort: 0

```
## Security
### Static yaml files analysis
```bash
docker run -i kubesec/kubesec scan /dev/stdin < <file.yml>
```
### Images analysis
```bash
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $HOME/Library/Caches:/root/.cache/ aquasec/trivy:0.36.1 image airseneo/iodevopens_webapp | tee result

# Critical and High vulnerabilities that can be fixed by updates:
docker run --rm -v /var/run/docker.sock:/var/run/docker.sock -v $HOME/Library/Caches:/root/.cache/ aquasec/trivy:0.36.1 image --ignore-unfixed --severity CRITICAL,HIGH airseneo/iodevopens_webapp | tee result
```

# Certification Tips:
## Pre Setup
Once you've gained access to your terminal it might be wise to spend ~1 minute to setup your environment. You could set these:
```bash
alias k=kubectl                         # will already be pre-configured
export do="--dry-run=client -o yaml"    # k create deploy nginx --image=nginx $do
export now="--force --grace-period 0"   # k delete pod x $now
```
### Vim
The following settings will already be configured in your real exam environment in ~/.vimrc. But it can never hurt to be able to type these down:
```bash
set tabstop=2
set expandtab
set shiftwidth=2
```
### tmux
```bash
# Vertical split
#crtl + shift + b + %

# Horizontal split
#crtl + shift + b + "

# move between split windows
#crtl + b + direction

# Dettach from  a session
#ctrl + b + d

# Create a session
#ctrl + b + c

# move between sessions
#ctrl + b + number
```
```bash
tmux ls
tmux new -s mysession
tmux kill-session -t mysession
```