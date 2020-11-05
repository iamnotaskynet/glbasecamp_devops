
#### Usefull links

- [terraform](https://www.terraform.io)
- [helm](https://helm.sh)
- [coreos.com/operators](https://coreos.com/operators)
- [getambassador](https://www.getambassador.com)
- [envoyproxy](https://www.envoyproxy.io)
- [istio](https://istio.io/)
- [prometheus.io](https://prometheus.io)
- [grafana.com/](https://grafana.com)
- [zipkin.io](https://zipkin.io)
- [elastic.co](https://www.elastic.co)
- [elasticsearch-operator](https://github.com/upmc-enterprises/elasticsearch-operator)
- [Monitor fun slides](https://conferences.xeraa.net/8h6lip)

- [12-factor app](https://en.wikipedia.org/wiki/Twelve-Factor_App_methodology)


#### Video

<!-- - [asciinema k8s session 3]() -->
- [youtube k8s session 3](https://www.youtube.com/watch?v=_Bm2Zpe6GuU)
- [zoom k8s session 3](https://globallogic.zoom.us/rec/share/5e6EG4monlf2LISawELi6iBDns62HoOEJ-AJ5yYmEpq2VnTUaWsby-Jd5MiYO_4N.7LkxaC-F1VC0eEqB)


#### Task

1. На повторение- деплой демо манифестов тремя методами: k create, k apply и k apply -f https://github… для app-secret.yaml и app-secret-env.yaml
2. Собрать демо аппликейшен на любом языке програмирования (пример https://github.com/gianarb/micro), условие: отвечать на два эндпоинта /healthz и /readinez. Создать YAML с настроенным livenessProbe и readinessProbe для этого аппликейшена