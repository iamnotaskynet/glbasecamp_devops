
#### Usefull links

- [k3s](https://k3s.io/)
- [traefik](https://traefik.io/)
- [k3sup](https://github.com/alexellis/k3sup)
- [kubernetes-the-hard-way](https://github.com/kelseyhightower/kubernetes-the-hard-way)


- [tmux cheatsheet](https://tmuxcheatsheet.com/)

#### Video

<!-- - [asciinema k8s session 2]() -->
- [youtube k8s session 2](https://www.youtube.com/watch?v=HEQYLPZhEUU)


#### Task

1. обновить имедж деплоймента на несуществующую версию и проверить description нерабочего пода и деплоймента
2. внести изменения в код, сбилдать и запушить контейнер имедж с нужной версие и убедиться что kuberentes восстановил стейт
3. Реализовать canary деплоймент для версии 2 в процентном соотнешении 90/10 для версии 1 и версии 2.  Рекомендуются к Использованию: create deploy, scale, label, edit и проверочный цикл while true; do curl