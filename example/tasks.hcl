consul {
  address = "127.0.0.1:8500"
}

driver "terraform" {
  log = true
  required_providers {
    aci = {
      source  = "CiscoDevNet/aci"
      version = "0.7.0"
    }
  }
}

terraform_provider "aci" {
  url      = "{{ env \"CISCO_ACI_URL\" }}"
  username = "{{ env \"CISCO_ACI_USER\" }}"
  password = "{{ env \"CISCO_ACI_PASSWORD\" }}"
}

buffer_period {
  min = "5s"
  max = "20s"
}

task {
  name        = "consul-to-aci-esg"
  description = "Synchronize services to ESGs"
  source      = "joatmon08/esg-nia/aci"
  providers   = ["aci"]
  services    = ["web", "api", "db"]
  variable_files = [
    "/Users/rosemarywang/joatmon08/terraform-aci-esg-nia/example/terraform.tfvars"
  ]
}
