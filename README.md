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


### b) For SQL-Server
Create linked service for SQL-Server with on-premises/local server, service principal and azure key vault
Test connection should be successful before creation.


## 4. Data Ingestion via Azure Data Factory
Upon creating the linked services for both HTTP-API and SQL-Server.

 ### a) HTTP API Ingestion
Create a pipeline in ADF to fetch data from the HTTP API.
Source: HTTP dataset pointing to the API.
Sink: ADLS Gen2 Bronze container.
![ls_http_api](https://github.com/user-attachments/assets/99db1177-4a34-4e71-9a98-da6dc69a3a8b)
![pipeline (http and server)](https://github.com/user-attachments/assets/afe4db08-9fd7-4f7a-8464-61501573813f)



 ### b. SQL Server Ingestion
Set up a self-hosted integration runtime for on-premises server.
Create a pipeline in ADF to copy data from SQL Server to the Bronze container.
Source: SQL dataset.
Sink: ADLS Gen2 Bronze container.
![ls_sql_server](https://github.com/user-attachments/assets/c20d8fa2-8949-4998-9316-0006c8d15312)
![pipeline (http and server)](https://github.com/user-attachments/assets/7a9529d4-873a-4634-8c3f-f365c3fde1ec)


## 4. Data Transformation in Azure Databricks
  
  ### a. Mount ADLS in Databricks
Mount the ADLS containers in Databricks using the access key or Key Vault.
![http_databricks1](https://github.com/user-attachments/assets/1e415072-55c3-4e40-800d-893374f4a995)
![http_databricks2](https://github.com/user-attachments/assets/489ccfe3-9dbe-4ec0-ac07-01de83aed8c0)
![sqldatabricks1](https://github.com/user-attachments/assets/ded3f67a-e7a1-4995-ac91-f6cf9df85ec0)
![sql_databricks2](https://github.com/user-attachments/assets/e9b8723d-077b-4570-8c7f-8360c9918a1e)


 ### b. Transform Data (Delta Processing)
Use Databricks notebooks to clean and transform the data.
Save the cleansed data into the Silver container.
![http_databricks3](https://github.com/user-attachments/assets/a7ea33d8-702a-49cc-a7cc-96ecc15bf7d9)
![http_databricks4](https://github.com/user-attachments/assets/111093fc-f09c-4081-b20f-85b93cd9386b)
![http_databricks5](https://github.com/user-attachments/assets/7acb8a5d-177b-462d-a64d-ae9266e48c9c)
![sql_databricks3](https://github.com/user-attachments/assets/6fffd848-b852-41dd-b8e7-6265b983848b)


 ### c. Stage Analytical Data (ETL)
Aggregate and enrich the data.
Save the analytical-ready data in the Gold container.
![http_databricks6](https://github.com/user-attachments/assets/4b4bce30-fc00-4961-9045-1071a82257be)
![sql_databricks4](https://github.com/user-attachments/assets/12c8aacf-7cc5-4988-9d1e-88cfbb759909)


## 5. Analytics with Azure Synapse
Create an external table in Synapse Analytics pointing to the Gold container.
Write SQL queries to analyze the data.

### a) External table - Gold Container (HTTP-API)


### b) External table - Gold Container (SQL-Server)



## Security Measures
Use Azure Key Vault to store secrets and keys securely.
Enable RBAC and access control on ADLS Gen2.
Scalability and Optimization
Enable autoscaling for Databricks clusters.
Optimize pipelines with parallelism in ADF.
Partition large datasets in ADLS for efficient querying.


## Conclusion
This project demonstrates the integration of Azure services to build a robust and scalable data pipeline for ingesting, transforming, and analyzing data. The combination of ADF, Databricks, and Synapse Analytics provides a flexible and high-performance solution for handling data at scale.

