.DEFAULT_GOAL := version

TF_DIR = src/cloud/infrastructure

## Workflow

init:
	terraform -chdir=$(TF_DIR) init -upgrade

plan: init
	terraform -chdir=$(TF_DIR) plan -input=false

apply: init
	terraform -chdir=$(TF_DIR) apply

fmt:
	terraform -chdir=$(TF_DIR) fmt -recursive

validate: init
	terraform -chdir=$(TF_DIR) validate

## CI

fmt-check:
	terraform -chdir=$(TF_DIR) fmt -check -recursive -diff

apply-auto-approve:
	terraform -chdir=$(TF_DIR) apply -auto-approve -input=false

## Debug

output: init
	terraform -chdir=$(TF_DIR) output -json

version:
	terraform -chdir=$(TF_DIR) version
