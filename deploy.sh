#!/bin/bash -eux

# TODO: s1/deploy.shがあれば優先する

cd go
go build -o isucondition

sudo systemctl restart nginx
sudo systemctl restart mysql
sudo systemctl restart isucondition.go.service
