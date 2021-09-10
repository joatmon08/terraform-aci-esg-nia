setup:
	cd example && docker-compose up -d
	cd aci && terraform init && terraform apply

fixtures:
	cd text/security/fixtures && terraform init && terraform plan -out tfplan && terraform show -json plan.json

tests:
	pytest .