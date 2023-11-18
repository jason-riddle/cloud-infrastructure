.DEFAULT_GOAL := version

TF_DIR = src/cloud/infrastructure

## Workflow

init:
	terraform -chdir=$(TF_DIR) init -upgrade

plan: init
	terraform -chdir=$(TF_DIR) plan

apply: init
	terraform -chdir=$(TF_DIR) apply

format:
	terraform -chdir=$(TF_DIR) fmt -recursive

validate:
	terraform -chdir=$(TF_DIR) validate

## CI

fmt-check:
	terraform -chdir=$(TF_DIR) fmt -check -recursive -diff

## Debug

version:
	terraform -chdir=$(TF_DIR) version
