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

variable "route53_zone_id" {
  default = ""
  type    = string
}
variable "route53_zone_base_domain" {
  description = "If route53_zone_id is an empty string, this variable is used to lookup the r53 zone dynamicaly"
  default     = ""
  type        = string
}

variable "route53_record_name" {
  type = string
}

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

variable "options" {
  description = "A list of Options to apply"
  type        = any
  default     = []
}

variable "subnet_group_name_override" {
  type        = string
  default     = ""
  nullable    = false
  description = "Override the subnet group name. If not set, the name will be the same as the name of the RDS instance"
}

variable "s3_integration_role_arn" {
  type     = string
  default  = ""
  nullable = false
}

variable "ca_cert_identifier" {
  description = "Specifies the identifier of the CA certificate for the DB instance"
  type        = string
  default     = "rds-ca-rsa2048-g1"
}