# OTUS_Project
## Project

Данный гит предназначен для сдачи проектной работы Administrator Linux.Basic онлайн-школы Otus.
В его процессе на основе готовых виртуальных машин на базе гипервизора Hyper-V разворачиваются следующие сервисы:
>1. Web-сервер1 Apache с привязкой к sql базе, Ubuntu 20.04 lts
>2. Web-сервер2 Apache с привязкой к sql базе, Ubuntu 20.04 lts
>3. Web-сервер Nginx, выполняющий роль балансировщика нагрузки для вебсерверов Apache, CentOS 7
>4. Сервер мониторинга Prometheus/Grafana, Ubuntu 20.04 lts
>5. Сервер ELK, CentOS 7 (предустановлен и настроен)

На ВМ вебсерверов Apache устанавливается:
 1. Mysql-server, их базы настраиваются в режим репликации Master-Master
 2. Сервисы Node_Extractor с последующим подключением к серверу Prometheus

Сервер Prometheus слушает себя и два сервера Apache
Сервер ELK читает логи балансировщика

## Скрипты, выполняющие установку и настройку программ:
### cloud1.conf для Web-сервер1.
>Скачиваются файлы: cloud1.conf (конфигурация apache), master1.conf (конфигурация mysql-server), node_exporter.service (сервис node_exporter), site1 (главная страница с запросом к БД))  
### cloud2.conf для Web-сервер2.
>Скачиваются файлы: cloud2.conf (конфигурация apache), master2.conf (конфигурация mysql-server), node_exporter.service (сервис node_exporter), site2 (главная страница с запросом к БД))  
### nginx.sh для балансировщика.
>Скачиваются файлы: default (конфигурация nginx). Также, с локального хранилища скачивается rpm пакет filebeat.rpm для установки соответствующего сервиса  
### promet.sh для сервера Prometheus.
>Скачиваются файлы: node_exporter.service (сервис node_exporter), prometheus.service (сервис prometheus), prometheus (файл конфигурации prometheus)  
скрипт fin.ps1 запускает установку

## Для правильной работы на ВМ должны быть настроены доступы по ssh-ключам, соответствующие пользователи должны быть в sudoers и иметь возможность беспарольного выполнения команд от su
