# Makefile
.PHONY: init plan apply test-policy clean

init:
	terraform init

plan:
	terraform plan -out=tfplan.binary
	terraform show -json tfplan.binary > tfplan.json

test-policy: plan
	conftest test tfplan.json

apply: test-policy
	terraform apply tfplan.binary

clean:
	rm -f tfplan.binary tfplan.json

