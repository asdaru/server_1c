# Контейнер с 1С сервером 8.2

Для запуска контейнера
NH_SERVER_ADDR - адреса ваших серверов с hasp ключами

```
docker run -h <имя хоста соответствующее имени компьютера в usr1cv82.keytab> -v /путь/к/рабочему/каталогу:/opt/1C/data -v /путь/к/файлу/usr1cv82.keytab:/opt/1C/v8.2/x86_64/usr1cv82.keytab:ro -e "NH_SERVER_ADDR = 168.192.0.9 , 192.168.0.5" -d -i -t -p 1500-1599:1500-1599 --restart=always --name server_1c  asdaru/server_1c
```
