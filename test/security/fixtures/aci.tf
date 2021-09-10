locals {
  annotation = "orchestrator:terraform"
  esg_prefix = "tf-aci-esg-nia-test"
}

data "terraform_remote_state" "aci" {
  backend = "local"

  config = {
    path = "../../../aci/terraform.tfstate"
  }
}

module "esg" {
  source                   = "../../.."
  services                 = var.services
  tenant_name              = data.terraform_remote_state.aci.outputs.tenant
  application_profile_name = data.terraform_remote_state.aci.outputs.app_profile
  vrf_name                 = data.terraform_remote_state.aci.outputs.vrf
  esg_prefix               = local.esg_prefix
}