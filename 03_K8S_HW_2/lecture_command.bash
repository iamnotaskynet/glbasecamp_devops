# GCP

gcloud compute \
    --project=k8s-k3s instances create master worker-1 \
    --zone=us-centrall-a 
    --tags=https-server,http-server \
    --metadata-from-file=ssh-keys=~/.ssh/k3s.pub
gcloud compute instances list --project=k8s-k3s

# setting k3s on remote machines
k3sup install --ip ${MACHINE_IP} --user ${USERNAME} --ssh-key ~/.ssh/k3s
#
mv ./kubeconfig ~/.kube/demo-config
alias k3=kubectl\ --kubeconfig\ ~/.kube/demo-config
#
k3 get all -A
# Pods
# Service

k3 get po -o wide -A