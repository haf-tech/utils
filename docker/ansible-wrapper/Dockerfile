# Dockerfile for Ansible inside Docker, like a Ansible wrapper
FROM debian:stretch

# ### Build arguments
# Ansible version
ARG ANSIBLE_VER=2.9.12
ARG BUILD_DATE
ARG VERSION

LABEL maintainer="code@haddouti.com" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.version=$VERSION \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.name="haf-tech/ansible-wrapper" \
    org.label-schema.description="Ansible Wrapper" \
    org.label-schema.url="https://github.com/haf-tech/utils" \
    org.label-schema.vcs-url="https://github.com/haf-tech/utils" \
    org.label-schema.vendor="haf-tech" \
    org.label-schema.docker.cmd="docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/id_rsa hafhub/ansible-wrapper:latest"



# Bootstrap Ansible via pip
RUN apt-get update && apt-get install -y python3-pip sshpass git openssh-client && \
    rm -rf /var/lib/apt/lists/* && \
    apt-get clean

RUN pip3 install --upgrade pip cffi && \
    pip install ansible==$ANSIBLE_VER && \
    pip install mitogen ansible-lint jmespath

# Prepare Ansible environment
RUN mkdir -p /ansible/roles && touch /ansible/.vaultpass
ENV ANSIBLE_ROLES_PATH /ansible/roles
#ENV ANSIBLE_VAULT_PASSWORD_FILE /ansible/.vaultpass

# Cleanup
RUN apt-get autoremove -y && apt-get autoclean -y && apt-get clean -y && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp* /usr/share/doc/*

# Environment setup
WORKDIR /ansible

ENTRYPOINT ["ansible-playbook"]

