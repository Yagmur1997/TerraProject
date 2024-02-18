locals {
  env    = "application layer"
  region = "us-east-2"
  tags = {
    env        = "${local.env}"
    region     = "${local.region}"
    team       = "infra"
    created_by = "devops Aidana"
  }
}