setup:
	cd example && docker-compose up -d
	cd aci && terraform init && terraform apply

fixture:
	cd test/security/fixtures && terraform init && terraform plan -out tfplan && terraform show -json tfplan > plan.json

tests:
	pytest .

cts:
	source secrets.env && consul-terraform-sync -config-file example/tasks.hcl

clean:
	cd sync-tasks/consul-to-aci-esg && ${HOME}/joatmon08/terraform-aci-esg-nia/terraform destroy \
		-auto-approve -var-file=terraform.tfvars -var-file=providers.tfvars \
		-var-file=${HOME}/joatmon08/terraform-aci-esg-nia/example/terraform.tfvars || true
	cd aci && terraform destroy -auto-approve
	cd example && docker-compose down
