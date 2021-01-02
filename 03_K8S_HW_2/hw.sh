# HW
# 0.0 k3sup servers
k3sup install \
    --ip 192.168.0.212  \
    --user iamnotaskynet \
    --ssh-key /home/iamnotaskynet/.ssh/id_rsa
k3sup join  \
    --user iamnotaskynet \
    --server-ip 192.168.0.212 \
    --ip 192.168.0.210 \
    --ssh-key /home/iamnotaskynet/.ssh/id_rsa

export KUBECONFIG=/home/iamnotaskynet/kubeconfig
# 0.1 Namespace
k create ns glbasecamp
k config set-context default --namespace glbasecamp

# 0.2 Preparetion 
tmux # Ctrl + b %     Ctrl + b "
bash pods_watch.sh
bash curl_requests.sh
# 0.3 Ports
k expose deploy glbasecamp --port 8080 --target-port 8000 --type LoadBalancer
k apply -f ingress.yml
# 1
k create deployment glbasecamp --image iamnotaskynet/gl_basecamp_test:0.4
k describe po ${working_pod} # to clurify container name
k set image deploy glbasecamp gl-basecamp-test-4smcp=iamnotaskynet/gl_basecamp_test:0.4.1 --record -n glbasecamp
k describe po ${not_working_pod}
k rollout history deploy glbasecamp
k rollout undo deploy glbasecamp --to-revision 1
# 2
docker build .
docker tag ${img_id} iamnotaskynet/gl_basecamp_test:0.4.1
docker push iamnotaskynet/gl_basecamp_test:0.4.1
k rollout undo deploy glbasecamp --to-revision 2


# 3
k scale deploy glbasecamp --replicas 9
k create deploy canary --image iamnotaskynet/gl_basecamp_test:0.4.2
k scale deploy canary --replicas 1
# test is deployment ok
k scale deploy glbasecamp --replicas 5
k scale deploy canary --replicas 5
k scale deploy glbasecamp --replicas 1
k scale deploy canary --replicas 10
k scale deploy glbasecamp --replicas 0


k delete deploy glbasecamp && k delete service glbasecamp && k delete namespaces glbasecamp && k config set-context default --namespace default