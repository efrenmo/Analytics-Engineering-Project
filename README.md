# Analytics Engineering Project

## Project Overview

### Problem Statement

The client, a company relying on various transactional databases for customer relationship management, enterprise resource planning, accounting, and other core functions, faced challenges in leveraging their data for business intelligence and analytical purposes. The client also had additional relevant data stored in cloud-based files but lacked a unified data management infrastructure necessary for comprehensive analysis. This project sought to bridge that gap by creating a comprehensive data engineering solution.

### Objective

To Engineere a comprehensive business intelligence solution consolidating multiple transactional databases and cloud-stored files into a unified Snowflake data warehouse that enabled data-driven decision making and actionable business insights.

<h2>Architecture and Technical Implementation</h2>
<p align="center">
  <img src="https://github.com/efrenmo/Analytics-Engineering-Project/blob/main/Screenshots/ae_infra_l.drawio.png" />
</p>

### Extract, Load, Transform, and Serve Pipeline Architecture

### Data Ingestion - Extract and Load

We have two main data sources; RDS PostgreSQL transactional databases, and csv files stored in AWS S3.

1. **Transactional databases - RDS PostgreSQL:**
   - We used Airbyte to replicate selected tables from PostgreSQL and map them to staging tables in the Snowflake data warehouse.
   - It enabled incremental replication from PostgreSQL into Snowflake.
     - Incremental SYNCS were configured using primary keys and cursor fields.
   - I configured connectors, managed schema mapping, and monitored pipeline health through Airbyte’s UI.
   - Airbyte was the tool of choice for its performance, product fit, and ease to use, in addition to being production-ready.  
     - **Performance:** Airbyte has made significant progress in improving its performance, with the Postgres connector now being faster than Fivetran for Postgres replication.
     - **Product fit:** It provides dedicated connectors for both PostgreSQL and Snowflake, ensuring seamless integration between the two platforms.
     - **Ease to use:** You can easily configure RDS as the source, and Snowflake as the destination, create a connection, and set-up a sync schedule directly from the Airbyte user interface.
     - **Production-Ready:** Airbyte is used by over 30,000 companies worldwide to cover their data pipeline needs, demonstrating its scalability and reliability as a data integration platform.     - 
2. **CSV files stored in AWS S3:**
     - To ingest CSV files from AWS S3 and load their data into tables in the Snowflake data warehouse, a **Lambda function** is configured to trigger when new CSV files are detected in a specific S3 bucket.
     - When activated, the Lambda function loads a custom Docker image from our private Elastic Container Registry (ECR) repository. This Docker image contains the necessary Python script and dependencies to establish connections with both AWS S3 and Snowflake, process the CSV file, and load its data into Snowflake.
     - Lambda function was the tool of choice for its event-driven processing, simplicity and speed, scalability and efficiency .

### Data Transformation
   - DBT (Data Build Tool) was central to our transformation layer. 
   - I wrote modular SQL models to clean, join, and reshape raw data into analytics-ready tables. 
   - I implemented type 2 slowly changing dimensions (SCD2) for historical tracking.
   - Organized models into staging, intermediate, and marts layers.
   - Used DBT’s testing framework to enforce data quality and catch anomalies early.

### Data Analytics
   - Utilized Metabase, a business intelligence tool, to create interactive dashboards and reports.
   - Enabled analysts to draw actionable insights from the transformed data.

### Technologies Used

- **Programming Language**: Python
- **Database**: PostgreSQL
- **Data Ingestion Tools**: Airbyte, AWS Cloud (EC2, Lambda, S3, ECR)
- **Containerization**: Docker
- **Data Warehouse**: Snowflake
- **Data Transformation Tool**: DBT
- **Business Intelligence Tool**: Metabase




