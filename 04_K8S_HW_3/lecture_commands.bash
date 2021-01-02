k apply -f yaml/app.yml -v 7

k exec app -n glbasecamp -- env

k create secret generic glbasecamp  --from-file=
                                    --from-literal=username=glbasecamp
                                    --from-literal=password=glbasecamp

k get secrets

k get secrets glbasecamp -o yaml

k create -f app-secret-env.yaml
k exec app-secret-env -- env

k create -f app-secret.yaml
k exec -it app-secret -- sh # and view its by cat /etc/foo/usename

k apply -f app-multicontainer.yaml
k exec -it app-two-containers -- sh

k port-forward app-two-containers 8088:80


