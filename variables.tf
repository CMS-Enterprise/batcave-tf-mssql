variable "name" {
  type = string
}

variable "auto_minor_version_upgrade" {
  type    = bool
  default = true
}

variable "port" {
  default = 1433
  type    = number
}

variable "allocated_storage" {
  default = 20 # minimum for RDS
  type    = number
}

variable "max_allocated_storage" {
  default = 100
  type    = number
}

variable "additional_attached_security_group_ids" {
  type    = list(string)
  default = []
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "master_username" {
  default = "admin"
  type    = string
}

variable "tags" {
  type = map(string)
  default = {
    Owner = "Batcave"
  }
}

#variable "route53_zone_id" {
#  default = ""
#  type    = string
#}
#variable "route53_zone_base_domain" {
#  description = "If route53_zone_id is an empty string, this variable is used to lookup the r53 zone dynamicaly"
#  default     = ""
#  type        = string
#}

#variable "route53_record_name" {
#  type = string
#}

variable "allowed_security_group_ids" {
  type    = list(string)
  default = []
}

variable "allowed_cidr_blocks" {
  type    = list(string)
  default = []
}

variable "allowed_prefix_lists" {
  type    = list(string)
  default = []
}

variable "apply_immediately" {
  default = false
  type    = bool
}

variable "instance_class" {
  default     = "db.r5.xlarge"
  description = "Instance classes for instances created under the cluster"
  type        = string
}

variable "deletion_protection" {
  type    = bool
  default = false
}

variable "backup_window" {
  type    = string
  default = "03:00-06:00"
}

variable "maintenance_window" {
  type    = string
  default = "Mon:00:00-Mon:03:00"
}

variable "create_random_password" {
  description = "Determines whether to create random password for RDS primary cluster"
  type        = bool
  default     = true
}

variable "backup_retention_period" {
  type        = number
  default     = 7
  description = "The days to retain backups for. Default 7"
}

variable "skip_final_snapshot" {
  type    = bool
  default = false
}

variable "subnet_group_name_override" {
  type        = string
  default     = ""
  nullable    = false
  description = "Override the subnet group name. If not set, the name will be the same as the name of the RDS instance"
}

#variable "s3_integration_role_arn" {
#  type     = string
#  default  = ""
#  nullable = false
#}

variable "ca_cert_identifier" {
  description = "Specifies the identifier of the CA certificate for the DB instance"
  type        = string
  default     = "rds-ca-rsa2048-g1"
}

variable "engine_version_number" {
  description = ""
  type        = string
  default     = "15.00"
}

variable "engine" {
  description = ""
  type        = string
  default     = "sqlserver-se"
}

variable "enabled_cloudwatch_logs_exports" {
  type    = list(any)
  default = ["agent", "error"]
}

variable "timezone" {
  type    = string
  default = "GMT Standard Time"
}

variable "character_set_name" {
  type    = string
  default = "Latin1_General_CI_AS"
}

variable "license_model" {
  type    = string
  default = "license-included"
}

variable "family" {
  type    = string
  default = "sqlserver-se-15.0"
}

variable "create_role" {
  description = "Whether to create a role"
  type        = bool
  default     = true
}

variable "role_name" {
  description = "Name of IAM role"
  type        = string
  default     = "vpc-cni"
}

variable "role_path" {
  description = "Path of IAM role"
  type        = string
  default     = "/delegatedadmin/developer/"
}

variable "role_description" {
  description = "IAM Role description"
  type        = string
  default     = null
}

variable "policy_name_prefix" {
  description = "IAM policy name prefix"
  type        = string
  default     = "AmazonEKS_"
}

variable "role_policy_arns" {
  description = "ARNs of any policies to attach to the IAM role"
  type        = map(string)
  default     = {}
}

variable "oidc_providers" {
  description = "Map of OIDC providers where each provider map should contain the `provider`, `provider_arn`, and `namespace_service_accounts`"
  type        = any
  default = {
    one = {
      provider_arn               = ""
      namespace_service_accounts = ["default:default"]
    }
  }
}

variable "force_detach_policies" {
  description = "Whether policies should be detached from this role when destroying"
  type        = bool
  default     = true
}

variable "max_session_duration" {
  description = "Maximum CLI/API session duration in seconds between 3600 and 43200"
  type        = number
  default     = null
}


variable "assume_role_condition_test" {
  description = "Name of the [IAM condition operator](https://docs.aws.amazon.com/IAM/latest/UserGuide/reference_policies_elements_condition_operators.html) to evaluate when assuming the role"
  type        = string
  default     = "StringEquals"
}

variable "aws_id" {
  description = "AWS Account Ids"
  type        = string
  default     = "111122223333"
}

variable "app_name" {
  description = "App name (ie. Flux, Velero, etc.)"
  type        = string
  default     = ""
}

# S3
variable "attach_s3_policy" {
  description = "Determines whether to attach the S3 to the role"
  type        = bool
  default     = false
}

variable "s3_bucket_arns" {
  description = "List of S3 Bucket ARNs to allow access to"
  type        = list(string)
  default     = [""]
}

variable "options" {
  description = "A list of Options to apply"
  type        = any
  default = [{
    option_name = "SQLSERVER_BACKUP_RESTORE"
    option_settings = [{
      name  = "IAM_ROLE_ARN"
      value = "arn:aws:iam::654654444899:role/delegatedadmin/developer/qmms2-np-s3-integration-np" # db-s3-role dependency
    }]
  }]
}

variable "role_permissions_boundary_arn" {
  description = "Permissions boundary ARN to use for IAM role"
  type        = string
  default     = "arn:aws:iam::654654444899:role/delegatedadmin/developer/qmms2-np-s3-integration-np"
}
