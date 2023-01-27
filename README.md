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