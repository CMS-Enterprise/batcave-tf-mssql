output "db_instance_arn" {
  description = "Amazon Resource Name (ARN) of RDS instance"
  value       = module.mssql-db.db_instance_arn
}

output "db_id" {
  description = "The RDS Identifier"
  value       = module.mssql-db.db_instance_name
}

output "db_resource_id" {
  description = "The RDS Resource ID"
  value       = module.mssql-db.db_instance_resource_id
}

output "db_endpoint" {
  description = "Endpoint for the db"
  value       = module.mssql-db.db_instance_endpoint
}

output "db_engine_version_actual" {
  description = "The running version of the RDS database"
  value       = module.mssql-db.db_instance_engine_version_actual
}

output "db_database_name" {
  description = "Name for an automatically created database on creation"
  value       = module.mssql-db.db_instance_name
}

output "db_port" {
  description = "The database port"
  value       = module.mssql-db.db_instance_port
}

output "db_master_password" {
  description = "The database master password"
  value       = module.mssql-db.db_instance_password
  sensitive   = true
}

output "db_master_username" {
  description = "The database master username"
  value       = module.mssql-db.db_instance_username
  sensitive   = true
}

output "db_hosted_zone_id" {
  description = "The Route53 Hosted Zone ID of the endpoint"
  value       = module.mssql-db.db_instance_hosted_zone_id
}
