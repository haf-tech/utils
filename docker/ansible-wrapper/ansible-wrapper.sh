#!/bin/bash

# Ansible wrapper script executing ansible from a docker container

docker run --rm -it \
  -v ~/.ssh/id_rsa:/root/.ssh/id_rsa \
  -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub \
  -v $(pwd):/ansible_playbooks \
  -v /var/log/ansible/ansible.log \
  hafhub/ansible-wrapper "$@"
