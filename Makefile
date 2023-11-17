.DEFAULT_GOAL := version

TF_DIR = src/cloud/infrastructure

## Workflow

init:
	terraform -chdir=$(TF_DIR) init -upgrade

plan: init
	terraform -chdir=$(TF_DIR) plan

format:
	terraform -chdir=$(TF_DIR) fmt -recursive

## CI

ci-fmt:
	terraform -chdir=$(TF_DIR) fmt -check -recursive -diff

## Debug

version:
	terraform -chdir=$(TF_DIR) version
