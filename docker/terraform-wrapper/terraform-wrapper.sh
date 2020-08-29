#!/bin/bash

# Terraform wrapper script executing terraform from a docker container

docker run --rm -it \
  -v $(pwd):/workpace -w /workpace \
  hashicorp/terraform:light "$@"
