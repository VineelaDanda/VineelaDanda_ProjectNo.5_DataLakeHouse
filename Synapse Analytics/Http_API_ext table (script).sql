IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'refined-gold_dvrdls1504_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [refined-gold_dvrdls1504_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://refined-gold@dvrdls1504.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.refined_users_delta (
	[city] nvarchar(4000),
	[count] bigint
	)
	WITH (
	LOCATION = 'refined_users_delta/**',
	DATA_SOURCE = [refined-gold_dvrdls1504_dfs_core_windows_net],
	FILE_FORMAT = [SynapseParquetFormat]
	)
GO


SELECT TOP 100 * FROM dbo.refined_users_delta
GO