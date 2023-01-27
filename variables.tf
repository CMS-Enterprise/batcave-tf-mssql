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

variable "vpc_security_group_ids" {
  type = list(string)
  default = []
}

variable "subnet_ids" {
  type = list(string)
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

variable "worker_security_group_id" {}
variable "cluster_security_group_id" {}
variable "cluster_primary_security_group_id" {}

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
  type = string
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
