provider "aws" {
  region  = var.dns_region
  alias   = "dns_region"
  profile = var.aws_profile

  default_tags {
    tags = var.aws_provider_default_tags
  }
}
