# Dockerfile for Ansible inside Docker, like a Ansible wrapper
FROM debian:stretch

# ### Build arguments
# Ansible version
ARG ANSIBLE_VER=2.9.12
ARG K8S_VER
ARG HELM_VER
ARG OC_VER
ARG BUILD_DATE
ARG VERSION

LABEL maintainer="code@haddouti.com" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.build-date=$BUILD_DATE \
    org.label-schema.version=$VERSION \
    org.label-schema.vcs-ref=$VCS_REF \
    org.label-schema.name="haf-tech/k8s-swiss" \
    org.label-schema.description="Kubernetes/OpenShift/Tekton helper imager" \
    org.label-schema.url="https://github.com/haf-tech/utils" \
    org.label-schema.vcs-url="https://github.com/haf-tech/utils" \
    org.label-schema.vendor="haf-tech" \
    org.label-schema.docker.cmd="docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/id_rsa hafhub/k8s-swiss:latest"



# Bootstrap Ansible via pip
RUN apt-get update && apt-get install -y python3-pip sshpass git openssh-client curl && \
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

# OpenShift CLI
RUN curl -sLo /tmp/oc.tar.gz https://mirror.openshift.com/pub/openshift-v$(echo $OC_VER | cut -d'.' -f 1)/clients/oc/$OC_VER/linux/oc.tar.gz && \
    tar xzvf /tmp/oc.tar.gz -C /usr/local/bin/ && \
    rm -rf /tmp/oc.tar.gz

# kubectl and hem
RUN curl -sLo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/v${K8S_VER}/bin/linux/amd64/kubectl && \
    chmod +x /usr/local/bin/kubectl && \
    curl -sL https://get.helm.sh/helm-v${HELM_VER}-linux-amd64.tar.gz | tar -xzO linux-amd64/helm > /usr/local/bin/helm && \
    chmod +x /usr/local/bin/helm


# Environment setup
WORKDIR /ansible

#ENTRYPOINT ["ansible-playbook"]

CMD bash