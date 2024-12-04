# project_data_lake_house

This project focuses on building a scalable data pipeline to ingest, transform, and store data in Azure Data Lake Storage (ADLS) Gen2 using Azure Data Factory (ADF), Azure Databricks, and Azure Synapse Analytics. Data is sourced from an HTTP API and Microsoft SQL Server, and it undergoes transformation and staging for further analysis.

## Prerequisites
Before starting, ensure we have the following Azure services set up:

1.Azure Data Lake Storage (ADLS) Gen2.
2.Azure Data Factory (ADF).
3.Azure Databricks.
4.Azure Key Vault.
5.Azure Synapse Analytics.

![Prerequisites (new)](https://github.com/user-attachments/assets/544fd4b2-e829-4f10-8fcd-fce68d031035)


## Access to HTTP API and SQL Server for source data.

## Project Setup and Implementation

## 1. Set Up Azure Data Lake Storage (ADLS) Gen2 

### a) For HTTP-API
Create a storage account with ADLS Gen2 enabled. ie., dvrdls1504
Set up the following containers:
**Bronze:** For raw data ingestion.
Silver: For cleansed and transformed data.
Gold: For analytical-ready data.

![Containers (http)](https://github.com/user-attachments/assets/382ddee8-5473-4984-88e0-cc8fb7e25a98)


### b) For SQL-Server
Create a storage account with ADLS Gen2 enabled. ie., dvrdls15
Set up the following containers:
**Bronze:** For raw data ingestion.
Silver: For cleansed and transformed data.
Gold: For analytical-ready data.

![Containers](https://github.com/user-attachments/assets/9008a271-baf9-43cc-bce5-b3a6403117a7)


## 2. Azure Key Vault Integration
Create a Key Vault to securely store sensitive information like API keys, SQL Server connection strings, and storage account access keys.
Add secrets for:
http_api_key
sql_server_conn_string
adls_access_key

![key vault and secret](https://github.com/user-attachments/assets/e778f9ea-93a7-4e49-b7b0-dab2f845e653)


## 3. Setup linked services in Azure Data Factory (ADF)

### a) For HTTP-API
Create linked service for http-api with base url, service principal and azure key vault
Test connection should be successful before creation.

![ls_http_api](https://github.com/user-attachments/assets/99db1177-4a34-4e71-9a98-da6dc69a3a8b)

### b) For SQL-Server
Create linked service for SQL-Server with on-premises/local server, service principal and azure key vault
Test connection should be successful before creation.

![ls_sql_server](https://github.com/user-attachments/assets/c20d8fa2-8949-4998-9316-0006c8d15312)


## 4. Data Ingestion via Azure Data Factory
Upon creating the linked services for both HTTP-API and SQL-Server.

 ### a) HTTP API Ingestion
Create a pipeline in ADF to fetch data from the HTTP API.

![pipeline (http and server)](https://github.com/user-attachments/assets/61776efe-e6bd-4471-ba66-c5f80e063d73)

Source: HTTP dataset pointing to the API.

![http_source (pipeline)](https://github.com/user-attachments/assets/362bfb18-5013-449d-a0ff-77b04090c455)

Sink: ADLS Gen2 Bronze container.

![http_sink (pipeline)](https://github.com/user-attachments/assets/4f5b2ba0-4b3e-403a-9ca8-f8a4acefb117)

![http_bronze (aftr pipeline)](https://github.com/user-attachments/assets/533a8e50-2818-4ee0-bdc7-1c69f23fb986)

 ### b. SQL Server Ingestion
Set up a self-hosted integration runtime for on-premises server.

![self-hosted IR](https://github.com/user-attachments/assets/96292503-3e7b-4062-bed7-10e4b9f6081d)

Create a pipeline in ADF to copy data from SQL Server to the Bronze container.

![pipeline (http and server)](https://github.com/user-attachments/assets/61776efe-e6bd-4471-ba66-c5f80e063d73)

Source: SQL dataset.

![sql_source (pipeline)](https://github.com/user-attachments/assets/bc8758f5-e416-4237-9e57-fd89db26dd1c)

Sink: ADLS Gen2 Bronze container.

![sql_sink (pipeline)](https://github.com/user-attachments/assets/582b3fbb-16e0-44a5-b1d2-9c02db29a7df)

![sql_bronze (aftr pipeline)](https://github.com/user-attachments/assets/03f4c805-3a12-499a-90e4-c780bcfacd32)


## 5. Data Transformation in Azure Databricks

### For HTTP-API

  ### a. Mount ADLS in Databricks
Mount the ADLS containers in Databricks using the access key or Key Vault.

![http_databricks notes 1](https://github.com/user-attachments/assets/a7d3a539-9f8d-4ad4-bc62-bf0c24cd1ff2)

![http_databricks notes 2](https://github.com/user-attachments/assets/5f129e3e-6556-4120-8ece-f8a151697d5b)

 ### b. Transform Data (Delta Processing)
Use Databricks notebooks to clean and transform the data.
Save the cleansed data into the Silver container.

![http_databricks notes 3](https://github.com/user-attachments/assets/d1d96d1a-3f50-48c2-9abe-286396e8512d)

![http_databricks notes 4](https://github.com/user-attachments/assets/26d818f6-9b20-4f44-a810-6fc7fd7d6167)

![http_databricks notes 5](https://github.com/user-attachments/assets/d45b3e61-b7e3-4801-a49c-cef265227875)

![http_databricks notes 6](https://github.com/user-attachments/assets/76237e60-4e89-4d16-8465-3266c174f427)

 ### c. Stage Analytical Data (ETL)
Aggregate and enrich the data.
Save the analytical-ready data in the Gold container.

![http_databricks notes 7](https://github.com/user-attachments/assets/68ffc312-ea14-41d4-ac64-1163e7ccfcfc)

![http_databricks notes 8](https://github.com/user-attachments/assets/da90fdcd-f213-414e-9383-122f41f31aae)


### For SQL-Server

  ### a. Mount ADLS in Databricks
Mount the ADLS containers in Databricks using the access key or Key Vault.

![sql_databricks notes 1](https://github.com/user-attachments/assets/bc09a3ce-e18e-4bd0-be04-70aa2ff623bc)

![sql_databricks notes 2](https://github.com/user-attachments/assets/06e594a4-3e1f-443f-b408-dda4339d5f03)

 ### b. Transform Data (Delta Processing)
Use Databricks notebooks to clean and transform the data.
Save the cleansed data into the Silver container.

![sql_databricks notes 3](https://github.com/user-attachments/assets/edcebaf9-0fab-4273-8046-7d39af0cc7a3)

![sql_databricks notes 4](https://github.com/user-attachments/assets/4e923a23-2e00-4622-9651-992ffb9b9f01)

![sql_databricks notes 5](https://github.com/user-attachments/assets/f1a3557e-63a5-4195-9721-e63cd7bd2a96)

![sql_databricks notes 6](https://github.com/user-attachments/assets/7d2173e2-8f60-402b-82ef-812477728c1f)

![sql_databricks notes 7](https://github.com/user-attachments/assets/b03df62a-7af7-4748-ba1a-792b28ea36eb)

![sql_databricks notes 8](https://github.com/user-attachments/assets/31766ab9-1c8f-4ae6-9343-71c875e9779e)

![sql_databricks notes 9](https://github.com/user-attachments/assets/9c030ba5-a14d-415d-b297-0f3a15f20d31)

 ### c. Stage Analytical Data (ETL)
Aggregate and enrich the data.
Save the analytical-ready data in the Gold container.

![sql_databricks notes 10](https://github.com/user-attachments/assets/710cdbc4-7f8b-49cf-adc6-1326080727d6)

![sql_databricks notes 11](https://github.com/user-attachments/assets/9c6bc171-6677-4b45-9db3-1614bf618829)


## 6. Analytics with Azure Synapse
Create an external table in Synapse Analytics pointing to the Gold container.
Write SQL queries to analyze the data.

### a) External table - Gold Container (HTTP-API)

![http-ext table](https://github.com/user-attachments/assets/a621c68d-10af-41c2-b4cc-3413bcd65dce)

![http_ext table-result](https://github.com/user-attachments/assets/4a1ed871-a507-4e9f-b9c9-051aee4eb813)

### b) External table - Gold Container (SQL-Server)

![sql_ext table](https://github.com/user-attachments/assets/10bc7e0b-bff7-432d-aa7c-3799b115771b)

![sql_ext table_result](https://github.com/user-attachments/assets/6991618a-6e22-4bff-8cb0-14b4e3237822)


## Security Measures
Use Azure Key Vault to store secrets and keys securely.
Enable RBAC and access control on ADLS Gen2.
Scalability and Optimization
Enable autoscaling for Databricks clusters.
Optimize pipelines with parallelism in ADF.
Partition large datasets in ADLS for efficient querying.


## Conclusion
This project demonstrates the integration of Azure services to build a robust and scalable data pipeline for ingesting, transforming, and analyzing data. The combination of ADF, Databricks, and Synapse Analytics provides a flexible and high-performance solution for handling data at scale.

