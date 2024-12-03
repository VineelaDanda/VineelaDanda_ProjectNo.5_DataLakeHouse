# project_data_lake_house

This project focuses on building a scalable data pipeline to ingest, transform, and store data in Azure Data Lake Storage (ADLS) Gen2 using Azure Data Factory (ADF), Azure Databricks, and Azure Synapse Analytics. Data is sourced from an HTTP API and Microsoft SQL Server, and it undergoes transformation and staging for further analysis.

## Prerequisites
Before starting, ensure we have the following Azure services set up:

1.Azure Data Lake Storage (ADLS) Gen2.
2.Azure Data Factory (ADF).
3.Azure Databricks.
4.Azure Key Vault.
5.Azure Synapse Analytics.
![pre-requisites](https://github.com/user-attachments/assets/809cebe9-11ec-4af9-bcfb-82f01b1e1793)



# Access to HTTP API and SQL Server for source data.

## Project Setup and Implementation
## 1. Set Up Azure Data Lake Storage (ADLS) Gen2
Create a storage account with ADLS Gen2 enabled.
Set up the following containers:
Bronze: For raw data ingestion.
Silver: For cleansed and transformed data.
Gold: For analytical-ready data.

## 2. Azure Key Vault Integration
Create a Key Vault to securely store sensitive information like API keys, SQL Server connection strings, and storage account access keys.
Add secrets for:
http_api_key
sql_server_conn_string
adls_access_key

## 3. Data Ingestion via Azure Data Factory
 ### a. HTTP API Ingestion
Create a pipeline in ADF to fetch data from the HTTP API.
Source: HTTP dataset pointing to the API.
Sink: ADLS Gen2 Bronze container.

 ### b. SQL Server Ingestion
Set up a self-hosted integration runtime for on-premises server.
Create a pipeline in ADF to copy data from SQL Server to the Bronze container.
Source: SQL dataset.
Sink: ADLS Gen2 Bronze container.

## 4. Data Transformation in Azure Databricks
  ### a. Mount ADLS in Databricks
Mount the ADLS containers in Databricks using the access key or Key Vault.

Copy code
spark.conf.set("fs.azure.account.key.<storage_account_name>.blob.core.windows.net", "<access_key>")

Verify the mount:
python
Copy code
dbutils.fs.ls("wasbs://bronze@<storage_account_name>.blob.core.windows.net/")

 ### b. Transform Data
Use Databricks notebooks to clean and transform the data.
Save the cleansed data into the Silver container.

 ### c. Stage Analytical Data
Aggregate and enrich the data.
Save the analytical-ready data in the Gold container.

## 5. Analytics with Azure Synapse
Create an external table in Synapse Analytics pointing to the Gold container.
Write SQL queries to analyze the data.


## Security Measures
Use Azure Key Vault to store secrets and keys securely.
Enable RBAC and access control on ADLS Gen2.
Scalability and Optimization
Enable autoscaling for Databricks clusters.
Optimize pipelines with parallelism in ADF.
Partition large datasets in ADLS for efficient querying.


## Conclusion
This project demonstrates the integration of Azure services to build a robust and scalable data pipeline for ingesting, transforming, and analyzing data. The combination of ADF, Databricks, and Synapse Analytics provides a flexible and high-performance solution for handling data at scale.

