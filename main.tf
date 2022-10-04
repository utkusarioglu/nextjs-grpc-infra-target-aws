module "aws" {
  source = "../../configs/aws"

  project_name                             = var.project_name
  aws_profile                              = var.aws_profile
  dns_region                               = var.dns_region
  iac_environment_tag                      = var.iac_environment_tag
  cluster_region                           = var.cluster_region
  cluster_name                             = var.cluster_name
  cluster_version                          = var.cluster_version
  name_prefix                              = var.name_prefix
  main_network_block                       = var.main_network_block
  subnet_prefix_extension                  = var.subnet_prefix_extension
  zone_offset                              = var.zone_offset
  eks_managed_node_groups                  = var.eks_managed_node_groups
  autoscaling_average_cpu                  = var.autoscaling_average_cpu
  spot_termination_handler_chart_name      = var.spot_termination_handler_chart_name
  spot_termination_handler_chart_repo      = var.spot_termination_handler_chart_repo
  spot_termination_handler_chart_version   = var.spot_termination_handler_chart_version
  spot_termination_handler_chart_namespace = var.spot_termination_handler_chart_namespace
  dns_base_domain                          = var.dns_base_domain
  ingress_gateway_name                     = var.ingress_gateway_name
  ingress_gateway_iam_role                 = var.ingress_gateway_iam_role
  ingress_gateway_chart_name               = var.ingress_gateway_chart_name
  ingress_gateway_chart_repo               = var.ingress_gateway_chart_repo
  ingress_gateway_chart_version            = var.ingress_gateway_chart_version
  external_dns_iam_role                    = var.external_dns_iam_role
  external_dns_chart_name                  = var.external_dns_chart_name
  external_dns_chart_repo                  = var.external_dns_chart_repo
  external_dns_chart_version               = var.external_dns_chart_version
  external_dns_values                      = var.external_dns_values
  admin_users                              = var.admin_users
  developer_users                          = var.developer_users
  user_create_sleep_duration               = var.user_create_sleep_duration
  project_root_rel_path                    = var.project_root_rel_path
  aws_provider_default_tags                = var.aws_provider_default_tags

  #relevant to app
  sld               = var.sld
  tld               = var.tld
  helm_timeout_unit = var.helm_timeout_unit
  helm_atomic       = var.helm_atomic


  providers = {
    aws.dns_region = aws.dns_region
    aws            = aws
  }
}
