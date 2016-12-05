###################################################
# Atlassian Jira
###################################################
ROOT_DIR := $(shell dirname $(realpath $(lastword $(MAKEFILE_LIST))))

JIRA_VERSION := 7.2.4
JIRA_INSTALL := /opt/atlassian/jira
JIRA_HOME := /data/jira

VERBOSE := ${VERBOSE-=0}

all: show_vars build push

LOCAL_USER_ID=$(shell id -u)

.PHONY: show_vars
show_vars:
	@ echo "########################################################################################"
	@ echo "# Atlassian Jira"
	@ echo "########################################################################################"
	@ echo "# ROOT_DIR:                   $(ROOT_DIR)"
	@ echo "# LOCAL_USER_ID:              $(LOCAL_USER_ID)"
	@ echo "# JIRA_VERSION:               $(JIRA_VERSION)"
	@ echo "# JIRA_INSTALL:               $(JIRA_INSTALL)"
	@ echo "# JIRA_HOME:                  $(JIRA_HOME)"
	@ echo "# VERBOSE:                    $(VERBOSE)"
	@ echo "########################################################################################"
	@ echo

.PHONY: create_env
create_env:
	echo LOCAL_USER_ID=${LOCAL_USER_ID} > ${ROOT_DIR}/.env
	echo CHOWNDIRS=${JIRA_INSTALL},${JIRA_HOME} >> ${ROOT_DIR}/.env
	echo VERBOSE=${VERBOSE} >> ${ROOT_DIR}/.env

.PHONY: serve
serve: create_env
	docker-compose up

.PHONY: build
build: create_env
	docker-compose build

.PHONY: push
push: build
	docker-compose push jira

.PHONY: default
default: show_vars create_env build push