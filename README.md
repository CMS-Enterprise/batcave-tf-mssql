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

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.2 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 4.61.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 4.61.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_mssql-db"></a> [mssql-db](#module\_mssql-db) | terraform-aws-modules/rds/aws | 5.2.3 |

## Resources

| Name | Type |
|------|------|
| [aws_db_subnet_group.db_subnet_group](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group) | resource |
| [aws_iam_role.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/iam_role_policy_attachment) | resource |
| [aws_security_group.mssql](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group_rule.db_egress](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.db_ingress_cidr_blocks](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.db_ingress_prefix_lists](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.db_ingress_security_groups](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group_rule) | resource |
| [aws_iam_policy_document.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_policy_document) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_attached_security_group_ids"></a> [additional\_attached\_security\_group\_ids](#input\_additional\_attached\_security\_group\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_allocated_storage"></a> [allocated\_storage](#input\_allocated\_storage) | n/a | `number` | `20` | no |
| <a name="input_allowed_cidr_blocks"></a> [allowed\_cidr\_blocks](#input\_allowed\_cidr\_blocks) | n/a | `list(string)` | `[]` | no |
| <a name="input_allowed_prefix_lists"></a> [allowed\_prefix\_lists](#input\_allowed\_prefix\_lists) | n/a | `list(string)` | `[]` | no |
| <a name="input_allowed_security_group_ids"></a> [allowed\_security\_group\_ids](#input\_allowed\_security\_group\_ids) | n/a | `list(string)` | `[]` | no |
| <a name="input_apply_immediately"></a> [apply\_immediately](#input\_apply\_immediately) | n/a | `bool` | `false` | no |
| <a name="input_assume_role_condition_test"></a> [assume\_role\_condition\_test](#input\_assume\_role\_condition\_test) | Name of the [IAM condition operator](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition_operators.html) to evaluate when assuming the role | `string` | `"StringEquals"` | no |
| <a name="input_auto_minor_version_upgrade"></a> [auto\_minor\_version\_upgrade](#input\_auto\_minor\_version\_upgrade) | n/a | `bool` | `true` | no |
| <a name="input_aws_id"></a> [aws\_id](#input\_aws\_id) | AWS Account Ids | `string` | `"111122223333"` | no |
| <a name="input_backup_retention_period"></a> [backup\_retention\_period](#input\_backup\_retention\_period) | The days to retain backups for. Default 7 | `number` | `7` | no |
| <a name="input_backup_window"></a> [backup\_window](#input\_backup\_window) | n/a | `string` | `"03:00-06:00"` | no |
| <a name="input_ca_cert_identifier"></a> [ca\_cert\_identifier](#input\_ca\_cert\_identifier) | Specifies the identifier of the CA certificate for the DB instance | `string` | `"rds-ca-rsa2048-g1"` | no |
| <a name="input_character_set_name"></a> [character\_set\_name](#input\_character\_set\_name) | n/a | `string` | `"Latin1_General_CI_AS"` | no |
| <a name="input_create_random_password"></a> [create\_random\_password](#input\_create\_random\_password) | Determines whether to create random password for RDS primary cluster | `bool` | `true` | no |
| <a name="input_create_role"></a> [create\_role](#input\_create\_role) | Whether to create a role | `bool` | `true` | no |
| <a name="input_deletion_protection"></a> [deletion\_protection](#input\_deletion\_protection) | n/a | `bool` | `false` | no |
| <a name="input_enabled_cloudwatch_logs_exports"></a> [enabled\_cloudwatch\_logs\_exports](#input\_enabled\_cloudwatch\_logs\_exports) | n/a | `list(any)` | <pre>[<br>  "agent",<br>  "error"<br>]</pre> | no |
| <a name="input_engine"></a> [engine](#input\_engine) | n/a | `string` | `"sqlserver-se"` | no |
| <a name="input_engine_version_number"></a> [engine\_version\_number](#input\_engine\_version\_number) | n/a | `string` | `"15.00"` | no |
| <a name="input_family"></a> [family](#input\_family) | n/a | `string` | `"sqlserver-se-15.0"` | no |
| <a name="input_force_detach_policies"></a> [force\_detach\_policies](#input\_force\_detach\_policies) | Whether policies should be detached from this role when destroying | `bool` | `true` | no |
| <a name="input_instance_class"></a> [instance\_class](#input\_instance\_class) | Instance classes for instances created under the cluster | `string` | `"db.r5.xlarge"` | no |
| <a name="input_license_model"></a> [license\_model](#input\_license\_model) | n/a | `string` | `"license-included"` | no |
| <a name="input_maintenance_window"></a> [maintenance\_window](#input\_maintenance\_window) | n/a | `string` | `"Mon:00:00-Mon:03:00"` | no |
| <a name="input_master_username"></a> [master\_username](#input\_master\_username) | n/a | `string` | `"admin"` | no |
| <a name="input_max_allocated_storage"></a> [max\_allocated\_storage](#input\_max\_allocated\_storage) | n/a | `number` | `100` | no |
| <a name="input_max_session_duration"></a> [max\_session\_duration](#input\_max\_session\_duration) | Maximum CLI/API session duration in seconds between 3600 and 43200 | `number` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | n/a | `string` | n/a | yes |
| <a name="input_oidc_providers"></a> [oidc\_providers](#input\_oidc\_providers) | Map of OIDC providers where each provider map should contain the `provider`, `provider_arn`, and `namespace_service_accounts` | `any` | <pre>{<br>  "one": {<br>    "namespace_service_accounts": [<br>      "default:default"<br>    ],<br>    "provider_arn": ""<br>  }<br>}</pre> | no |
| <a name="input_options"></a> [options](#input\_options) | A list of Options to apply | `any` | <pre>[<br>  {<br>    "option_name": "SQLSERVER_BACKUP_RESTORE",<br>    "option_settings": [<br>      {<br>        "name": "IAM_ROLE_ARN",<br>        "value": "arn:aws:iam::654654444899:role/delegatedadmin/developer/qmms2-np-s3-integration-np"<br>      }<br>    ]<br>  }<br>]</pre> | no |
| <a name="input_port"></a> [port](#input\_port) | n/a | `number` | `1433` | no |
| <a name="input_role_description"></a> [role\_description](#input\_role\_description) | IAM Role description | `string` | `null` | no |
| <a name="input_role_name"></a> [role\_name](#input\_role\_name) | Name of IAM role | `string` | `"vpc-cni"` | no |
| <a name="input_role_path"></a> [role\_path](#input\_role\_path) | Path of IAM role | `string` | `"/delegatedadmin/developer/"` | no |
| <a name="input_role_permissions_boundary_arn"></a> [role\_permissions\_boundary\_arn](#input\_role\_permissions\_boundary\_arn) | Permissions boundary ARN to use for IAM role | `string` | `"arn:aws:iam::373346310182:policy/cms-cloud-admin/developer-boundary-policy"` | no |
| <a name="input_role_policy_arns"></a> [role\_policy\_arns](#input\_role\_policy\_arns) | ARNs of any policies to attach to the IAM role | `map(string)` | `{}` | no |
| <a name="input_skip_final_snapshot"></a> [skip\_final\_snapshot](#input\_skip\_final\_snapshot) | n/a | `bool` | `false` | no |
| <a name="input_subnet_group_name_override"></a> [subnet\_group\_name\_override](#input\_subnet\_group\_name\_override) | Override the subnet group name. If not set, the name will be the same as the name of the RDS instance | `string` | `""` | no |
| <a name="input_subnet_ids"></a> [subnet\_ids](#input\_subnet\_ids) | n/a | `list(string)` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | n/a | `map(string)` | <pre>{<br>  "Owner": "Batcave"<br>}</pre> | no |
| <a name="input_timezone"></a> [timezone](#input\_timezone) | n/a | `string` | `"GMT Standard Time"` | no |
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
