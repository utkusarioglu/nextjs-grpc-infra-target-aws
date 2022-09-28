provider "aws" {
  region  = var.dns_region
  alias   = "dns_region"
  profile = var.aws_profile

  default_tags {
    tags = {
      iac_environment = var.iac_environment_tag
      ProjectName     = var.cluster_name
      MetaRepo        = "nextjs-grpc"
      Repo            = "infra/aws"
      Region          = "DNS region"
      DefaultProvider = "false"
    }
  }
}

provider "aws" {
  region  = var.cluster_region
  profile = var.aws_profile

  default_tags {
    tags = {
      iac_environment = var.iac_environment_tag
      ProjectName     = var.cluster_name
      MetaRepo        = "nextjs-grpc"
      Repo            = "infra/aws"
      Region          = "Cluster region"
      DefaultProvider = "true"
    }
  }
}

provider "helm" {
  kubernetes {
    host                   = module.aws.cluster_endpoint
    cluster_ca_certificate = module.aws.cluster_ca_certificate
    token                  = module.aws.cluster_token
  }
}
