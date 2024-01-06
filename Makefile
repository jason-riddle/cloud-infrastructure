.DEFAULT_GOAL := version

# If .secrets file exists, include the file and export all env vars.
-include .secrets
.EXPORT_ALL_VARIABLES:

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

backup: backup-cf-zone-records backup-cf-page-rules
backup-cf-zone-records:
	pushd $(TF_DIR) ; \
	cf-terraforming generate \
		--resource-type "cloudflare_record" \
		--zone $$CLOUDFLARE_ZONE_ID | tee cf-zone-records.tf.backup ; \
	popd

backup-cf-page-rules:
	pushd $(TF_DIR) ; \
	cf-terraforming generate \
		--resource-type "cloudflare_page_rule" \
		--zone $$CLOUDFLARE_ZONE_ID | tee cf-page-rules.tf.backup ; \
	popd

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
