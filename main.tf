locals {
  engine_version_short = split(".", var.engine_version)[0]
  tags                 = var.tags
}

module "mssql-db" {
  identifier = var.name
  source  = "terraform-aws-modules/rds/aws"
  version = "5.2.3"

  engine               = "sqlserver-se"
  engine_version       = "15.00"
  family               = "sqlserver-se-15.0"
  major_engine_version = "15.00"
  instance_class       = var.instance_class

  allocated_storage     = var.allocated_storage
  max_allocated_storage = var.max_allocated_storage
  storage_encrypted     = true

  username               = var.master_username
  create_random_password = var.create_random_password
  port                   = var.port

  multi_az               = false
  db_subnet_group_name   = aws_db_subnet_group.db_subnet_group.name
  vpc_security_group_ids = var.vpc_security_group_ids

  maintenance_window              = var.maintenance_window
  backup_window                   = var.backup_window
  enabled_cloudwatch_logs_exports = ["agent","error"]
  create_cloudwatch_log_group     = true

  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot
  deletion_protection     = var.deletion_protection
  apply_immediately = var.apply_immediately

  performance_insights_enabled = false
  create_monitoring_role       = false

  options = var.options

  create_db_parameter_group = true
#  parameter_group_name      = aws_db_parameter_group.db_parameter_group.name
  license_model             = "license-included"
  timezone                  = "GMT Standard Time"
  character_set_name        = "Latin1_General_CI_AS"

  tags = local.tags
  copy_tags_to_snapshot = true
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "db_subnet_group"
  subnet_ids = var.subnet_ids
}

data "aws_route53_zone" "cms_zone" {
  count        = var.route53_zone_base_domain != "" ? 1 : 0
  name         = var.route53_zone_base_domain
  private_zone = true
}

resource "aws_route53_record" "www" {
  zone_id = coalesce(var.route53_zone_id, try(data.aws_route53_zone.cms_zone[0].zone_id, ""))
  name    = var.route53_record_name
  type    = "CNAME"
  ttl     = "60"
  records = [module.mssql-db.db_instance_endpoint]
}

# mssql egress rule for cluster_security_group
resource "aws_security_group_rule" "db-egress-cluster_security_group" {
  type                     = "egress"
  description              = "mssql traffic"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = var.vpc_security_group_ids[0]
  security_group_id        = var.cluster_security_group_id
}

# mssql egress rule for worker_security_group
resource "aws_security_group_rule" "db-egress-worker_security_group" {
  type                     = "egress"
  description              = "mssql traffic"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = var.vpc_security_group_ids[0]
  security_group_id        = var.worker_security_group_id
}

# mssql egress rule for cluster_primary_security_group
resource "aws_security_group_rule" "db-egress-cluster_primary_security_group" {
  type                     = "egress"
  description              = "mssql traffic"
  from_port                = 0
  to_port                  = 0
  protocol                 = "-1"
  source_security_group_id = var.vpc_security_group_ids[0]
  security_group_id        = var.cluster_primary_security_group_id
}
