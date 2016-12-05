###################################################
# Atlassian Jira, Bamboo & Crowd
###################################################

.PHONY: build
build:
	cd jira && $(MAKE) build
	cd bamboo && $(MAKE) build
	cd crowd && $(MAKE) build

.PHONY: push
push:
	cd jira && $(MAKE) push
	cd bamboo && $(MAKE) push
	cd crowd && $(MAKE) push

.PHONY: default
default: build push