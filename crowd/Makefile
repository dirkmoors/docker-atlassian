###################################################
# Atlassian Crowd
###################################################
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

CROWD_VERSION := 2.11.0
CROWD_INSTALL := /opt/atlassian/crowd
CROWD_HOME := /data/crowd

VERBOSE := ${VERBOSE-=0}

all: show_vars build push

LOCAL_USER_ID=$(shell id -u)

.PHONY: show_vars
show_vars:
	@ echo "########################################################################################"
	@ echo "# Atlassian Crowd"
	@ echo "########################################################################################"
	@ echo "# ROOT_DIR:                   $(ROOT_DIR)"
	@ echo "# LOCAL_USER_ID:              $(LOCAL_USER_ID)"
	@ echo "# CROWD_VERSION:              $(CROWD_VERSION)"
	@ echo "# CROWD_INSTALL:              $(CROWD_INSTALL)"
	@ echo "# CROWD_HOME:                 $(CROWD_HOME)"
	@ echo "# VERBOSE:                    $(VERBOSE)"
	@ echo "########################################################################################"
	@ echo

.PHONY: create_env
create_env:
	echo LOCAL_USER_ID=${LOCAL_USER_ID} > ${ROOT_DIR}/.env
	echo CHOWNDIRS=${CROWD_INSTALL},${CROWD_HOME} >> ${ROOT_DIR}/.env
	echo VERBOSE=${VERBOSE} >> ${ROOT_DIR}/.env

.PHONY: serve
serve: create_env
	docker-compose up

.PHONY: build
build: create_env
	docker-compose build

.PHONY: push
push: build
	docker-compose push crowd

.PHONY: default
default: show_vars create_env build push