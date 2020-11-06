k version --insecure-skip-tls-verify

helm version

helm repo list

helm repo add datawire https://www.getambassador.io

helm repo update

helm install ambassador datawire/ambassador --set image.repository=docker.io/datawire/ambassador --set image.tag=1.8.1 --set enableAES=false

helm status ambasador

helm create app

helm template ./app demo --namespace demo

...

k port-forward svc/ambassador-admin 8877

browser http://localhost:8877/ambassador/v0/diag/