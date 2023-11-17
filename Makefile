.DEFAULT_GOAL := version

## Workflow

init:
	terraform init -upgrade

## Debug

version:
	terraform version
