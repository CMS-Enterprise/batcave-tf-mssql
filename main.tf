locals {
  engine_version_short = split(".", var.engine_version)[0]
  tags                 = var.tags
}

module "mssql-db" {
  identifier = var.name
  source     = "terraform-aws-modules/rds/aws"
  version    = "5.2.3"

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
  vpc_security_group_ids = concat([aws_security_group.mssql.id], var.additional_attached_security_group_ids)

  maintenance_window              = var.maintenance_window
  backup_window                   = var.backup_window
  enabled_cloudwatch_logs_exports = ["agent", "error"]
  create_cloudwatch_log_group     = true

  backup_retention_period = var.backup_retention_period
  skip_final_snapshot     = var.skip_final_snapshot
  deletion_protection     = var.deletion_protection
  apply_immediately       = var.apply_immediately

  performance_insights_enabled = false
  create_monitoring_role       = false

  options = var.options

  create_db_parameter_group = true
  #  parameter_group_name      = aws_db_parameter_group.db_parameter_group.name
  license_model      = "license-included"
  timezone           = "GMT Standard Time"
  character_set_name = "Latin1_General_CI_AS"

  tags                  = local.tags
  copy_tags_to_snapshot = true
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = coalesce(var.subnet_group_name_override, var.name)
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

resource "aws_db_instance_role_association" "s3_integration" {
  count                  = var.s3_integration_role_arn != "" ? 1 : 0
  db_instance_identifier = module.mssql-db.db_instance_id
  feature_name           = "S3_INTEGRATION"
  role_arn               = var.s3_integration_role_arn
}

# mssql ingress rules
resource "aws_security_group_rule" "db_ingress_security_groups" {
  for_each                 = toset(var.allowed_security_group_ids)
  type                     = "ingress"
  description              = "mssql traffic"
  from_port                = 1433
  to_port                  = 1433
  protocol                 = "6"
  source_security_group_id = each.value
  security_group_id        = aws_security_group.mssql.id
}

resource "aws_security_group_rule" "db_ingress_cidr_blocks" {
  for_each          = toset(var.allowed_cidr_blocks)
  type              = "ingress"
  description       = "mssql traffic"
  from_port         = 1433
  to_port           = 1433
  protocol          = "6"
  cidr_blocks       = [each.value]
  security_group_id = aws_security_group.mssql.id
}

resource "aws_security_group_rule" "db_ingress_prefix_lists" {
  for_each          = toset(var.allowed_prefix_lists)
  type              = "ingress"
  description       = "mssql traffic"
  from_port         = 1433
  to_port           = 1433
  protocol          = "6"
  prefix_list_ids   = [each.value]
  security_group_id = aws_security_group.mssql.id
}

# egress cidr for updates
resource "aws_security_group_rule" "db_egress" {
  type              = "egress"
  description       = "all outbound traffic"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.mssql.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group" "mssql" {
  name        = "${var.name}-mssql"
  description = "mssql security group"
  vpc_id      = var.vpc_id
}
