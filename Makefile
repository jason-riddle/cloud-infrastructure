.DEFAULT_GOAL := version

# If .secrets file exists, include the file and export all env vars.
-include .secrets
.EXPORT_ALL_VARIABLES:

TF_DIR = src/cloud/infrastructure

CF_BKUP_DIR = x/backups/cloudflare
TS_BKUP_DIR = x/backups/tailscale

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

ls: init
	terraform -chdir=$(TF_DIR) state list

backup: backup-cf-zone-records backup-cf-page-rules \
		backup-cf-zone-settings-overrides backup-ts-golinks


backup-cf-zone-records:
	pushd $(TF_DIR) ; \
	mkdir -p $(CF_BKUP_DIR) ; \
	cf-terraforming generate \
		--resource-type "cloudflare_record" \
		--zone $$CLOUDFLARE_ZONE_ID | tee $(CF_BKUP_DIR)/cf-zone-records.tf.backup ; \
	popd

backup-cf-page-rules:
	pushd $(TF_DIR) ; \
	mkdir -p $(CF_BKUP_DIR) ; \
	cf-terraforming generate \
		--resource-type "cloudflare_page_rule" \
		--zone $$CLOUDFLARE_ZONE_ID | tee $(CF_BKUP_DIR)/cf-page-rules.tf.backup ; \
	popd

backup-cf-zone-settings-overrides:
	pushd $(TF_DIR) ; \
	mkdir -p $(CF_BKUP_DIR) ; \
	cf-terraforming generate \
		--resource-type "cloudflare_zone_settings_override" \
		--zone $$CLOUDFLARE_ZONE_ID | tee $(CF_BKUP_DIR)/cf-zone-settings-overrides.tf.backup ; \
	popd

backup-ts-golinks:
	pushd $(TF_DIR) ; \
	mkdir -p $(TS_BKUP_DIR) ; \
	curl -fsSL http://go/.export | tee $(TS_BKUP_DIR)/ts-golinks.jsonl ; \
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
