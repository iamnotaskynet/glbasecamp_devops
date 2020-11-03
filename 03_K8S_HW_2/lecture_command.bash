# GCP

gcloud compute \
    --project=k8s-k3s instances create master worker-1 \
    --zone=us-centrall-a 
    --tags=https-server,http-server \
    --metadata-from-file=ssh-keys=~/.ssh/k3s.pub
gcloud compute instances list --project=k8s-k3s

# setting k3s on remote machines
k3sup install --ip ${MACHINE_IP} --user ${USERNAME} --ssh-key ~/.ssh/${key}
#
mv ./kubeconfig ~/.kube/demo-config
alias k3=kubectl\ --kubeconfig\ ~/.kube/demo-config
#
k get all -A
# Pods
k get po -o wide -A
# Service
k get svc -A
# Endpoints 
k get ep -A
# Deployment
k get deploy -A
k get deploy -A -o wide

# kubectl completion
source <(kubectl completion bash)

#
k create 
k apply -f https://github...

# show namespaces
k get ns
# create namespace
k create ns demo
# commands with declared namespace
k get po -n demo
# and without will show default namespace
k get po

# Show current namespase 
k config current-context
# Set namespace
k config set-context default --namespace demo

# Deployment
k create deployment demo --image nginx
k create deployment demo --image gcr.io/k8s-k3s/demo:v1.0.0
k get deploy
k logs ${container}
k exec -it ${container} -- sh

k expose deploy demo --port 8080 --target-port 8000 --type LoadBalancer

#
k3 apply -f - <<"EOF"
kind: Ingress
apiVersion: networking.k8s.io/v1beta1
metadata:
  name: ingress
  namespace: demo
spec:
  rules:
    - host:
      http:
        paths:
        - path: /
          backend:
            serviceName: demo
            servicePort: 8080
EOF
#

# Image update
k set image deploy demo demo=gcr.io/k8s-k3s/demo:v2.0.0 --record -n demo
k rollout history deploy demo
k rollout undo deploy demo --to-revision 1
k delete po ${pod}

k set image deploy demo demo=gcr.io/k8s-k3s/demo:${unexistedversion} --record -n demo
k describe po ${pod}
k scale deploy demo --replicas 10
k get svc -o wide
k get ep 
k get po --show-labels
k get po -Lapp -lapp
k get po -Lapp -lapp=demo

k edit deploy demo

