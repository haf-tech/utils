#!/bin/bash

# Ansible wrapper script executing ansible from a docker container

# use make or execute this command manually
#docker build --rm --build-arg BUILD_DATE=$(date -u +'%Y-%m-%dT%H:%M:%SZ') --build-arg VERSION=0.1 -t hafhub/ansible-wrapper:0.1 -f Dockerfile .

docker run --rm -it \
  -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
  -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
  -v $(pwd):/ansible_playbooks \
  -v /var/log/ansible/ansible.log \
  hafhub/ansible-wrapper:0.1 "$@"
