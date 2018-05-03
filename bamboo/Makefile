###################################################
# Atlassian Bamboo
###################################################
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

BAMBOO_VERSION := 6.5.0
BAMBOO_INSTALL := /opt/atlassian/bamboo
BAMBOO_HOME := /data/bamboo

VERBOSE := ${VERBOSE-=0}

all: show_vars build push

LOCAL_USER_ID=$(shell id -u)

.PHONY: show_vars
show_vars:
	@ echo "########################################################################################"
	@ echo "# Atlassian Bamboo"
	@ echo "########################################################################################"
	@ echo "# ROOT_DIR:                   $(ROOT_DIR)"
	@ echo "# LOCAL_USER_ID:              $(LOCAL_USER_ID)"
	@ echo "# BAMBOO_VERSION:             $(BAMBOO_VERSION)"
	@ echo "# BAMBOO_INSTALL:             $(BAMBOO_INSTALL)"
	@ echo "# BAMBOO_HOME:                $(BAMBOO_HOME)"
	@ echo "# VERBOSE:                    $(VERBOSE)"
	@ echo "########################################################################################"
	@ echo

.PHONY: create_env
create_env:
	echo LOCAL_USER_ID=${LOCAL_USER_ID} > ${ROOT_DIR}/.env
	echo CHOWNDIRS=${BAMBOO_INSTALL},${BAMBOO_HOME} >> ${ROOT_DIR}/.env
	echo VERBOSE=${VERBOSE} >> ${ROOT_DIR}/.env

.PHONY: serve
serve: create_env
	docker-compose up

.PHONY: build
build: create_env
	docker-compose build

.PHONY: push
push: build
	docker-compose push bamboo

.PHONY: default
default: show_vars create_env build push
