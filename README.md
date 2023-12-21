# batcave-tf-mssql

This is a Terraform module for a Microsoft SQL Server (Standard Edition) for AWS RDS

- Note that credentials are stored in AWS Secrets Manger

## Debugging Tips
Once the mssql RDS is up and running, you may want to test connectivity from the cluster.  To do this:
1. Start an interactive diagnostic pod with mssql tooling (note your shell will hang, so you'll likely need multiple terminals open):
```shell
  kubectl run mssql-diag --image=mcr.microsoft.com/mssql-tools --restart=Never -n default --overrides='{"spec":{"tolerations":[{"effect": "NoSchedule","key": "CriticalAddonsOnly","operator": "Exists" }]}}' -i --tty
```

2. In a separate terminal, shell into the `mssql-diag` pod and run the following command to test connectivity:
```shell
sqlcmd -U regscale -P <password> -S <server-url> -Q "SELECT * FROM SYSOBJECTS WHERE xtype='U';"
```

You should see output showing the tables in the mssql database.

3. Delete the `mssql-diag` pod when finished

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mssql-db"></a> [mssql-db](#module\_mssql-db) | terraform-aws-modules/rds/aws | 5.2.3 |

## Resources

| Name | Type |
|------|------|
| [aws_db_instance_role_association.s3_integration](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance_role_association) | resource |
| [aws_db_subnet_group.db_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_route53_record.www](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.mssql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.db_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.db_ingress_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.db_ingress_prefix_lists](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.db_ingress_security_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_route53_zone.cms_zone](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/route53_zone) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_attached_security_group_ids"></a> [additional\_attached\_security\_group\_ids](#input\_additional\_attached\_security\_group\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | n/a | `number` | `20` | no |
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | n/a | `list(string)` | `[]` | no |
| <a name="input_allowed_prefix_lists"></a> [allowed\_prefix\_lists](#input\_allowed\_prefix\_lists) | n/a | `list(string)` | `[]` | no |
| <a name="input_allowed_security_group_ids"></a> [allowed\_security\_group\_ids](#input\_allowed\_security\_group\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | n/a | `bool` | `false` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | n/a | `bool` | `true` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The days to retain backups for. Default 7 | `number` | `7` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | n/a | `string` | `"03:00-06:00"` | no |
| <a name="input_create_random_password"></a> [create\_random\_password](#input\_create\_random\_password) | Determines whether to create random password for RDS primary cluster | `bool` | `true` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | n/a | `bool` | `false` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | Instance classes for instances created under the cluster | `string` | `"db.r5.xlarge"` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | n/a | `string` | `"Mon:00:00-Mon:03:00"` | no |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | n/a | `string` | `"admin"` | no |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | n/a | `number` | `100` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `any` | n/a | yes |
| <a name="input_options"></a> [options](#input\_options) | A list of Options to apply | `any` | `[]` | no |
| <a name="input_port"></a> [port](#input\_port) | n/a | `number` | `1433` | no |
| <a name="input_route53_record_name"></a> [route53\_record\_name](#input\_route53\_record\_name) | n/a | `any` | n/a | yes |
| <a name="input_route53_zone_base_domain"></a> [route53\_zone\_base\_domain](#input\_route53\_zone\_base\_domain) | If route53\_zone\_id is an empty string, this variable is used to lookup the r53 zone dynamicaly | `string` | `""` | no |
| <a name="input_route53_zone_id"></a> [route53\_zone\_id](#input\_route53\_zone\_id) | n/a | `string` | `""` | no |
| <a name="input_s3_integration_role_arn"></a> [s3\_integration\_role\_arn](#input\_s3\_integration\_role\_arn) | n/a | `string` | `""` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | n/a | `bool` | `false` | no |
| <a name="input_subnet_group_name_override"></a> [subnet\_group\_name\_override](#input\_subnet\_group\_name\_override) | Override the subnet group name. If not set, the name will be the same as the name of the RDS instance | `string` | `""` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | <pre>{<br>  "Owner": "Batcave"<br>}</pre> | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | n/a | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_db_database_name"></a> [db\_database\_name](#output\_db\_database\_name) | Name for an automatically created database on creation |
| <a name="output_db_endpoint"></a> [db\_endpoint](#output\_db\_endpoint) | Endpoint for the db |
| <a name="output_db_engine_version_actual"></a> [db\_engine\_version\_actual](#output\_db\_engine\_version\_actual) | The running version of the RDS database |
| <a name="output_db_hosted_zone_id"></a> [db\_hosted\_zone\_id](#output\_db\_hosted\_zone\_id) | The Route53 Hosted Zone ID of the endpoint |
| <a name="output_db_id"></a> [db\_id](#output\_db\_id) | The RDS Identifier |
| <a name="output_db_instance_arn"></a> [db\_instance\_arn](#output\_db\_instance\_arn) | Amazon Resource Name (ARN) of RDS instance |
| <a name="output_db_master_password"></a> [db\_master\_password](#output\_db\_master\_password) | The database master password |
| <a name="output_db_master_username"></a> [db\_master\_username](#output\_db\_master\_username) | The database master username |
| <a name="output_db_port"></a> [db\_port](#output\_db\_port) | The database port |
| <a name="output_db_resource_id"></a> [db\_resource\_id](#output\_db\_resource\_id) | The RDS Resource ID |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
