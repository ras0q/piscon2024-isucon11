#!/bin/bash -eux

# TODO: s1/deploy.shがあれば優先する

# Log
# NOTE: mysql-slow.log must be readable by both mysql and isucon user
sudo chmod +r /var/log/*
sudo sudo usermod -aG mysql isucon
sudo rm -rf /var/log/mysql/mysql-slow.log \
  && sudo touch /var/log/mysql/mysql-slow.log \
  && sudo chmod +r /var/log/mysql/mysql-slow.log \
  && sudo chown mysql:mysql /var/log/mysql \
  && sudo chown mysql:mysql /var/log/mysql/mysql-slow.log
sudo rm -rf /var/log/nginx/access.log \
  && sudo touch /var/log/nginx/access.log \
  && sudo chmod +r /var/log/nginx/access.logi

cd go
go build -o isucondition

sudo systemctl restart nginx
sudo systemctl restart mysql
sudo systemctl restart isucondition.go.service

# Slow Query Log
sudo mysql -uisucon -pisucon -e 'SET GLOBAL long_query_time = 0; SET GLOBAL slow_query_log = ON; SET GLOBAL slow_query_log_file = "/var/log/mysql/mysql-slow.log";'
