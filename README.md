# OTUS_Project
## Project

Данный гит предназначен для сдачи проектной работы Administrator Linux.Basic онлайн-школы Otus.  
В его процессе на основе подготовленных виртуальных машин на базе гипервизора Hyper-V разворачиваются следующие сервисы:
>1. Web-сервер1 Apache, Ubuntu 20.04 lts
>2. Web-сервер2 Apache, Ubuntu 20.04 lts
>3. Web-сервер Nginx,, CentOS 7
>4. Сервер мониторинга Prometheus/Grafana, Ubuntu 20.04 lts
>5. Сервер ELK, CentOS 7

### Скрипты, выполняющие установку и настройку программ:
>### Скрипт fin.ps1 запускает установку в Powershell:
>#### web1.conf для Web-сервер1.
>Скачиваются файлы: master1.conf (конфигурация mysql-server), node_exporter.service (сервис node_exporter), site1 (главная страница с запросом к БД))  
>#### web2.conf для Web-сервер2.
>Скачиваются файлы: master2.conf (конфигурация mysql-server), node_exporter.service (сервис node_exporter), site2 (главная страница с запросом к БД))  
>#### nginx.sh для балансировщика.
>Скачиваются файлы: default (конфигурация nginx). Также, с локального хранилища скачиваются rpm пакеты nginx и filebeat.rpm для установки соответствующих сервисов  
>#### promet.sh для сервера Prometheus.
>Скачиваются файлы: node_exporter.service (сервис node_exporter), prometheus.service (сервис prometheus), prometheus (файл конфигурации prometheus). Также, с локального хранилища скачивается deb пакет grafana.deb для установки соответствующего сервиса
>#### elk.sh для сервера ELK.
>Скачиваются файлы: все файлы скачиваются с локального хранилища  

### В результате исполнения скрипта получаются:
>1. Два сервера Apache, которые тянут запись из реплицируемой Master-Master таблицы mysql
>2. Сервер Nginx, выполняющий роль балансировщика трафика
>3. Сервер Prometheus мониторит себя и два сервера Apache
>4. Сервер ELK собирает логи с балансировщика
