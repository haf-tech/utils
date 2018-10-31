# Dockerfile for Ansible inside Docker, like a Ansible wrapper
FROM debian:9

# Bootstrap Ansible via pip
RUN apt-get update && apt-get install -y wget gcc make python python-dev python-setuptools python-pip libffi-dev libssl-dev libyaml-dev
RUN pip install -U pip
RUN pip install -U ansible

# Prepare Ansible environment
RUN mkdir /ansible
ENV ANSIBLE_ROLES_PATH /ansible/roles
ENV ANSIBLE_VAULT_PASSWORD_FILE /ansible/.vaultpass

# Cleanup
RUN apt-get purge -y python-dev python-pip
RUN apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y
RUN rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp* /usr/share/doc/*

# Environment setup
WORKDIR /ansible

ENTRYPOINT ["ansible-playbook"]

