

#### Video

- [asciinema k8s session 1]()
- [youtube k8s session 2](https://www.youtube.com/watch?v=HEQYLPZhEUU&feature=youtu.be)
- [zoom k8s session 2](https://globallogic.zoom.us/rec/share/7XPzFHajS1YFWhEvXoYn1YDCEg0-xkFUysNzrsN5qfROYpIVtm9_NNgaY2aPM0D0.KU6C522xZGmljt8Z)


#### Task

1. обновить имедж деплоймента на несуществующую версию и проверить description нерабочего пода и деплоймента
2. внести изменения в код, сбилдать и запушить контейнер имедж с нужной версие и убедиться что kuberentes восстановил стейт
3. Реализовать canary деплоймент для версии 2 в процентном соотнешении 90/10 для версии 1 и версии 2.  Рекомендуются к Использованию: create deploy, scale, label, edit и проверочный цикл while true; do curl