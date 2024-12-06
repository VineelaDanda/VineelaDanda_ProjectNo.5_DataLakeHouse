IF NOT EXISTS (SELECT * FROM sys.external_file_formats WHERE name = 'SynapseParquetFormat') 
	CREATE EXTERNAL FILE FORMAT [SynapseParquetFormat] 
	WITH ( FORMAT_TYPE = PARQUET)
GO

IF NOT EXISTS (SELECT * FROM sys.external_data_sources WHERE name = 'gold_dvrdls15_dfs_core_windows_net') 
	CREATE EXTERNAL DATA SOURCE [gold_dvrdls15_dfs_core_windows_net] 
	WITH (
		LOCATION = 'abfss://gold@dvrdls15.dfs.core.windows.net' 
	)
GO

CREATE EXTERNAL TABLE dbo.refined_students_delta (
	[ID] nvarchar(4000),
	[FIRST_NAME] nvarchar(4000),
	[LAST_NAME] nvarchar(4000),
	[DOB] date,
	[ingestion_timestamp] datetime2(7)
	)
	WITH (
	LOCATION = 'refined_students_delta/**',
	DATA_SOURCE = [gold_dvrdls15_dfs_core_windows_net],
	FILE_FORMAT = [SynapseParquetFormat]
	)
GO

SELECT TOP 100 * FROM dbo.refined_students_delta
GO