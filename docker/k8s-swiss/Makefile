# Makefile for building docker image and running it

default: build 

# Build Docker image
build: docker_build output

# Build and push Docker image
release: docker_build docker_push output

# Image and binary can be overidden with env vars.
DOCKER_IMAGE ?= hafbluebox/k8s-swiss
BINARY ?= k8s-swiss
ANSIBLE_VER ?= 2.10.7
K8S_VER ?= 1.21.0
HELM_VER ?= 3.5.4
OC_VER ?= 4.5

# Get the latest commit
GIT_COMMIT = $(strip $(shell git rev-parse --short HEAD))

# Get the version number from the code
CODE_VERSION = $(strip $(shell cat VERSION))


ifndef CODE_VERSION
$(error VERSION file missing)
endif

DOCKER_TAG = $(CODE_VERSION)

CHECK_GIT_CLEAN = FALSE
# Find out if the working directory is clean
GIT_NOT_CLEAN_CHECK = $(shell git status --porcelain)
ifneq (x$(GIT_NOT_CLEAN_CHECK), x)
DOCKER_TAG_SUFFIX = "-dirty"
endif


docker_build: 
	# Build Docker image
	docker build \
  --build-arg ANSIBLE_VER=$(ANSIBLE_VER) \
  --build-arg K8S_VER=$(K8S_VER) \
  --build-arg HELM_VER=$(HELM_VER) \
  --build-arg OC_VER=$(OC_VER) \
  --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
  --build-arg VERSION=$(CODE_VERSION) \
  --build-arg VCS_URL=`git config --get remote.origin.url` \
  --build-arg VCS_REF=$(GIT_COMMIT) \
	-t $(DOCKER_IMAGE):$(DOCKER_TAG) .

docker_push:   
	
	# Do not release it if it is not a pushed repo
	ifeq ($(CHECK_GIT_CLEAN), TRUE)
	ifneq (x$(GIT_NOT_CLEAN_CHECK), x)
	$(error echo Release not allowed. Git repo still dirty. Commit and push first.)
	endif
	endif

	# Tag image as latest
	docker tag $(DOCKER_IMAGE):$(DOCKER_TAG) $(DOCKER_IMAGE):latest

	# Push to DockerHub
	docker push $(DOCKER_IMAGE):$(DOCKER_TAG)
	docker push $(DOCKER_IMAGE):latest

output:
	@echo Docker Image: $(DOCKER_IMAGE):$(DOCKER_TAG)
