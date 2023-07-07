variable "name" {}
variable "engine_version" {
  default = "15.00"
}

variable "port" {
  default = 1433
}

variable "allocated_storage" {
  default = 20 # minimum for RDS
}

variable "max_allocated_storage" {
  default = 100
}

variable "additional_attached_security_group_ids" {
  type    = list(string)
  default = []
}

variable "subnet_group_name" {
  type    = string
  default = "db_subnet_group"
}

variable "subnet_ids" {
  type = list(string)
}

variable "vpc_id" {
  type = string
}

variable "master_username" {
  default = "admin"
}
variable "database_name" {}

variable "tags" {
  type = map(string)
  default = {
    Owner = "Batcave"
  }
}

variable "route53_zone_id" {
  default = ""
}
variable "route53_zone_base_domain" {
  description = "If route53_zone_id is an empty string, this variable is used to lookup the r53 zone dynamicaly"
  default     = ""
}

variable "route53_record_name" {}

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
}

variable "instance_class" {
  default     = "db.r5.xlarge"
  description = "Instance classes for instances created under the cluster"
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
